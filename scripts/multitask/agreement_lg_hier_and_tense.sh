seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset agreement_and_tense \
    --max_train_steps 200000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 100000 \
    --save_dir /nlp/scr/amirzur/multitask_agreement_lg_hier_and_tense_s$seed \
    --grammar agreement_hr_v4 \
    --data_dir grammar_gen_hier_data \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab tense