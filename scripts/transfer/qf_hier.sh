from=$1
cp=$2

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset lm \
    --max_train_steps 100000 \
    --max_grad_norm 1 \
    --eval_every 1000 \
    --seed 42 \
    --tied-embedding \
    --shared_vocab data_utils/shared_vocab/shared_vocab.json \
    --save_every 1000000 \
    --save_dir ${from}_to_qf_hier \
    --data_dir question_formation_hier_data \
    --model_load_path $from/$cp