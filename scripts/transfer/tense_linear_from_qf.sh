# special file for when we transfer from multi-qf, which has a different vocabulary
from=$1
cp=$2
warmup=$3

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset tense \
    --max_train_steps 100000 \
    --eval_every 1000 \
    --seed 42 \
    --tied-embedding \
    --save_every 100000 \
    --save_dir transfer_${from}_to_tense_linear \
    --data_dir tense_inflection_linear_data \
    --model_load_path $from \
    --model_load_checkpoint $cp \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all \
    --num_embed_warmup_steps $warmup