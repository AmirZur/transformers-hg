from=$1
cp=$2

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset simple_agreement \
    --max_train_steps 100000 \
    --eval_every 1000 \
    --seed 42 \
    --tied-embedding \
    --save_every 100000 \
    --save_dir ${from}_to_agree_lg_hier \
    --grammar agreement_hr_v4 \
    --data_dir grammar_gen_hier_data \
    --model_load_path $from \
    --model_load_checkpoint $cp \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab tense