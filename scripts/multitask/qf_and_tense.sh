seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --max_grad_norm 1 \
    --callback \
    --dataset qf_and_tense \
    --max_train_steps 300000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 150000 \
    --save_dir /nlp/scr/amirzur/multitask_qf_and_tense_s$seed \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all