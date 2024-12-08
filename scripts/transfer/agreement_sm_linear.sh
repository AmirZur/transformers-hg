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
    --save_every 1000000 \
    --save_dir ${from}_to_agree_sm_linear \
    --grammar agreement_linear \
    --data_dir grammar_gen_linear_data \
    --model_load_path $from \
    --model_load_checkpoint $cp \
    --wandb_dir /nlp/scr/amirzur