seed=$1

uv run python train_transformers.py \
    --encoder_n_layers 6 \
    --max_grad_norm 1 \
    --callback \
    --dataset qf_and_tense \
    --max_train_steps 80000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 10000 \
    --save_dir /nlp/scr/amirzur/qf_and_tense_past_s${seed} \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all \
    --data_dir tense_inflection_past_data