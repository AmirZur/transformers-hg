# special file for when we transfer from multi-qf, which has a different vocabulary
from=$1
cp=$2

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset tense \
    --max_train_steps 100000 \
    --eval_every 1000 \
    --seed 42 \
    --tied-embedding \
    --save_every 1000000 \
    --save_dir transfer_${from}_to_tense_hier \
    --data_dir tense_inflection_hier_data \
    --model_load_path $from \
    --model_load_checkpoint $cp \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all