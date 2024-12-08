seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset simple_agreement \
    --max_train_steps 200000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 100000 \
    --save_dir /nlp/scr/amirzur/checkpoint_agreement_lg_linear_svocab_s$seed \
    --grammar agreement_linear_v4 \
    --data_dir grammar_gen_linear_data \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab