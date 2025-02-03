from=$1
cp=$2
warmup=$3

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset lm \
    --max_train_steps 100000 \
    --max_grad_norm 1 \
    --eval_every 1000 \
    --seed 42 \
    --tied-embedding \
    --save_every 100000 \
    --save_dir ${from}_to_qf_hier \
    --data_dir question_formation_hier_data \
    --model_load_path $from \
    --model_load_checkpoint $cp \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all \
    --num_embed_warmup_steps $warmup