seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset tense \
    --max_train_steps 300000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --shared_vocab data_utils/shared_vocab/shared_vocab.json \
    --save_every 150000 \
    --save_dir /nlp/scr/amirzur/checkpoint_tense_s$seed