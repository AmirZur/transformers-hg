import argparse
import os
from typing import List
from tqdm import tqdm
import plotly.express as px
import einops
import torch
from torch.utils.data import DataLoader
from datasets import Dataset
from nnsight import NNsight

import collate
from counterfactuals import agreement_cf, tense_cf, qf_cf
from transformer_helpers import create_lm
from data_utils import build_datasets_tense_inflection, build_datasets_lm
from vocabulary import WordVocabulary
from models.transformer_lm import TransformerLM

ENCODER_N_LAYERS = 6
N_HEADS = 8

def load_lm(
    model_name : str,
    model_checkpoint : str,
    in_vocab : WordVocabulary, 
    device : torch.device = torch.device('cuda')
) -> TransformerLM:
    if not model_checkpoint.endswith('.pickle'):
        model_checkpoint += '.pickle'

    vec_dim = 512
    mode = 'enc_dec'
    no_pos_enc = False
    pos_scale = 1.0
    gated_model = False
    dropout = 0.1
    tied_embedding = True

    lm = create_lm(
        len(in_vocab),
        vec_dim,
        N_HEADS,
        ENCODER_N_LAYERS,
        mode=mode,
        use_pos_embeddig=not no_pos_enc,
        pos_scale=pos_scale,
        gated_model=gated_model,
        dropout=dropout,
        tied_embedding=tied_embedding,
    ).to(device)

    state_dict = torch.load(f'{model_name}/{model_checkpoint}', map_location=torch.device("cpu"))
    # load_model(model, state_dict, old_vocab, in_vocab)
    lm.load_state_dict(state_dict)

    return lm

def preprocess(
    lm : TransformerLM,
    in_vocab : WordVocabulary,
    example : dict, 
    key : str = 'base'
):
    data_in = in_vocab(example[key])
    data_in_len = len(data_in)

    data = {
        "in": torch.tensor(data_in).unsqueeze(1),
        "in_len": torch.tensor([data_in_len]),
    }

    in_len = data["in_len"].long() + 1

    sos_tensor = torch.ones((1, data["in"].shape[1])) * lm.encoder_sos
    sos_tensor = sos_tensor.to(data["in"].device)
    inp_data = torch.cat(
        [sos_tensor, data["in"]],
        dim=0,
    ).transpose(0, 1)

    return inp_data, in_len

def activation_patching(
    lm : TransformerLM,
    cf_dataset : List[str],
    in_vocab : WordVocabulary,
    batch_size : int = 32,
    device : torch.device = torch.device('cuda')
):
    # preprocess dataset
    base_preprocessed = [preprocess(lm, in_vocab, example, key='base') for example in cf_dataset]
    source_preprocessed = [preprocess(lm, in_vocab, example, key='source') for example in cf_dataset]

    cf_dataset_preprocessed = {
        'base': list(zip(*base_preprocessed))[0],
        'base_len': list(zip(*base_preprocessed))[1],
        'source': list(zip(*source_preprocessed))[0],
        'source_len': list(zip(*source_preprocessed))[1],
        'matrix_verb_index': [example['matrix_verb_index'] for example in cf_dataset],
        'cf_label': [in_vocab(example['cf_label']) for example in cf_dataset],
        'base_label': [in_vocab(example['base_label']) for example in cf_dataset],
    }

    cf_hf_dataset = Dataset.from_dict(cf_dataset_preprocessed)

    collator = collate.VarLengthCollate(None)

    cf_dataloader = DataLoader(
        cf_hf_dataset,
        batch_size=batch_size,
        collate_fn=collator,
    )

    print(f'Preprocessed {len(cf_dataset)} examples for activation patching')

    # run activation patching!
    all_patching_results = []
    all_patching_results_unnorm = []
    all_base_logit_diffs = []
    all_src_logit_diffs = []
    for batch in tqdm(cf_dataloader):
        # b x s
        base_data = batch['base'].squeeze(0).to(device)
        source_data = batch['source'].squeeze(0).to(device)
        # b 
        base_lens = batch['base_len'].squeeze(0).to(device)
        source_lens = batch['source_len'].squeeze(0).to(device)
        cf_labels = batch['cf_label'].squeeze(0).long().to(device)
        base_labels = batch['base_label'].squeeze(0).long().to(device)
        logit_ids = batch['matrix_verb_index'].squeeze(0).long().to(device)
        b = base_data.shape[0]

        # collect base logits
        with torch.no_grad():
            base_out = lm(base_data, base_lens)
        # negative (floor)
        base_logit_diff = base_out.data[range(b), logit_ids, cf_labels] - base_out.data[range(b), logit_ids, base_labels] 
        all_base_logit_diffs.append(base_logit_diff.cpu())

        # collect activations for each layer in source example
        src_attns = []
        with torch.no_grad():
            with NNsight(lm).trace(source_data, source_lens) as source_run:
                for l in range(ENCODER_N_LAYERS):
                    src_attn = source_run.trafo.encoder.layers[l].self_attn.multi_head_merge.input.save()
                    src_attns.append(src_attn)
                # collect source logits
                src_out = source_run.output.save()

        # positive (ceiling)
        src_logit_diff = src_out.value.data[range(b), logit_ids, cf_labels] - src_out.value.data[range(b), logit_ids, base_labels] 
        all_src_logit_diffs.append(src_logit_diff.cpu())

        # reorganize source activations by [layer, head]
        for l in range(ENCODER_N_LAYERS):
            layer_attn = einops.rearrange(
                src_attns[l].value, 'b s (nh dh) -> b s nh dh',
                nh=N_HEADS
            )
            head_attns = []
            for h in range(N_HEADS):
                head_attns.append(layer_attn[:, :, h, :])
            src_attns[l] = torch.stack(head_attns, dim=0)
        src_attns = torch.stack(src_attns, dim=0)
        # print('Collected source activations (l x h x b x s x dh):', src_attns.shape)

        def norm_diff(patched_diff):
            # how far did we bring it towards the source?
            return (patched_diff - base_logit_diff) / (src_logit_diff - base_logit_diff).abs()

        patching_results = []
        patching_results_unnorm = []
        for l in range(ENCODER_N_LAYERS):
            patch_layer_results = []
            patch_layer_results_unnorm = []
            for h in range(N_HEADS):
                with torch.no_grad():
                    with NNsight(lm).trace(base_data, base_lens) as patched_run:
                        base_attn = patched_run.trafo.encoder.layers[l].self_attn.multi_head_merge.input
                        base_attn = einops.rearrange(
                            base_attn, 'b s (nh dh) -> b s nh dh',
                            nh=N_HEADS
                        )
                        # patch head from source
                        base_attn[:, :, h, :] = src_attns[l][h]
                        base_attn = einops.rearrange(
                            base_attn, 'b s nh dh -> b s (nh dh)'
                        )
                        patched_run.trafo.encoder.layers[l].self_attn.multi_head_merge.input = base_attn
                        cf_res = patched_run.output.save()
                
                cf_logit_diff = cf_res.value.data[range(b), logit_ids, cf_labels] - cf_res.value.data[range(b), logit_ids, base_labels]
                patch_layer_results.append(norm_diff(cf_logit_diff))
                patch_layer_results_unnorm.append(cf_logit_diff - base_logit_diff)
            patching_results.append(torch.stack(patch_layer_results, dim=0))
            patching_results_unnorm.append(torch.stack(patch_layer_results_unnorm, dim=0))

        all_patching_results.append(torch.stack(patching_results, dim=0).cpu().permute(2, 0, 1))
        all_patching_results_unnorm.append(torch.stack(patching_results_unnorm, dim=0).cpu().permute(2, 0, 1))

    all_patching_results =  torch.cat(all_patching_results, dim=0)
    all_patching_results_unnorm =  torch.cat(all_patching_results_unnorm, dim=0)
    all_base_logit_diffs = torch.cat(all_base_logit_diffs, dim=0)
    all_src_logit_diffs = torch.cat(all_src_logit_diffs, dim=0)
    return all_patching_results, all_patching_results_unnorm, all_base_logit_diffs, all_src_logit_diffs

def show_results(patching_results, save_path : str):
    fig = px.imshow(
        patching_results.mean(dim=0),
        color_continuous_scale="RdBu",
        color_continuous_midpoint=0.0,
        title="Activation Patching Over Attention Heads",
        labels={"x": "Head", "y": "Layer","color":"Norm. Logit Diff"},
        text_auto=".2f"
    )

    fig.write_image(save_path)

def main(
    model_name : str,
    model_checkpoint : str,
    cf_dataset_name : str,
    num_per_generation : int = 2,
    hier : bool = False,
    g_name : str = 'agreement_hr_v4', # only use if cf_dataset = agreement
    batch_size : int = 32,
    device : str = 'cuda',
    seed : int = 0,
    save_tensors : bool = False
):
    _, in_vocab, tense_sentences = build_datasets_tense_inflection(
        include_only_present=False,
        include_only_past_and_simple_present=False
    )

    if 'qf' in model_name:
        # QF models have combined tense + QF vocabulary
        _, _, qf_sentences = build_datasets_lm(
            include_only_quest=False,
            include_only_decls_nd_simpl_ques=False,
            include_only_complex_sents=False,
        )

        in_vocab = WordVocabulary(
            tense_sentences + qf_sentences, 
            split_punctuation=False
        )

    device = torch.device(device)
    lm = load_lm(model_name, model_checkpoint, in_vocab, device=device)

    if cf_dataset_name == 'agreement':
        cf_dataset = agreement_cf(hier=hier, g_name=g_name, num_per_generation=num_per_generation, seed=seed)
    elif cf_dataset_name == 'tense':
        cf_dataset = tense_cf(hier=hier, num_per_generation=num_per_generation, seed=seed)
    elif cf_dataset_name == 'qf':
        cf_dataset = qf_cf(hier=hier, num_per_generation=num_per_generation, seed=seed)
    else:
        raise ValueError(f'Unknown cf_dataset_name: {cf_dataset_name}')
    
    all_patching_results, all_patching_results_unnorm, all_base_logit_diffs, all_src_logit_diffs = activation_patching(
        lm, cf_dataset, in_vocab, batch_size=batch_size, device=device
    )

    print('Saving results...')
    save_dir = 'patching_results/' + model_name[model_name.rfind('/')+1:]
    os.makedirs(save_dir, exist_ok=True)

    cf_type = 'hier' if hier else 'linear'
    if save_tensors:
        torch.save(all_patching_results, f'{save_dir}/{cf_dataset_name}_{cf_type}_patching_results.pt')
        torch.save(all_patching_results_unnorm, f'{save_dir}/{cf_dataset_name}_{cf_type}_patching_results_unnorm.pt')
        torch.save(all_base_logit_diffs, f'{save_dir}/{cf_dataset_name}_{cf_type}_base_logit_diffs.pt')
        torch.save(all_src_logit_diffs, f'{save_dir}/{cf_dataset_name}_{cf_type}_src_logit_diffs.pt')

    show_results(all_patching_results, f'{save_dir}/{cf_dataset_name}_{cf_type}_patching_results.png')
    show_results(all_patching_results_unnorm, f'{save_dir}/{cf_dataset_name}_{cf_type}_patching_results_unnorm.png')
    
    return all_patching_results, all_base_logit_diffs, all_src_logit_diffs

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--model_name', type=str, required=True)
    parser.add_argument('--model_checkpoint', type=str, required=True)
    parser.add_argument('--cf_dataset_name', type=str, required=True)
    parser.add_argument('--num_per_generation', type=int, default=2)
    parser.add_argument('--hier', action='store_true')
    parser.add_argument('--g_name', type=str, default='agreement_hr_v4')
    parser.add_argument('--batch_size', type=int, default=32)
    parser.add_argument('--device', type=str, default='cuda')
    parser.add_argument('--seed', type=int, default=0)
    parser.add_argument('--save_tensors', action='store_true')
    args = parser.parse_args()

    main(
        args.model_name,
        args.model_checkpoint,
        args.cf_dataset_name,
        args.num_per_generation,
        args.hier,
        args.g_name,
        args.batch_size,
        args.device,
        args.seed,
        args.save_tensors
    )