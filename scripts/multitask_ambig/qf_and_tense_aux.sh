seed=$1
ratio=$2

python train_transformers.py \
    --encoder_n_layers 6 \
    --max_grad_norm 1 \
    --callback \
    --dataset qf_and_tense \
    --max_train_steps 100000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 100000 \
    --save_dir /nlp/scr/amirzur/qf_and_tense_aux_r${ratio}_s${seed} \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab all \
    --multitask_ratio $ratio \
    --data_dir tense_inflection_aux_data