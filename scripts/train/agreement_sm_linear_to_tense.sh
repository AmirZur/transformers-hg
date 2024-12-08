seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset agreement_to_tense \
    --max_train_steps 200000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 100000 \
    --save_dir /nlp/scr/amirzur/checkpoint_agreement_sm_linear_to_tense_s$seed \
    --grammar agreement_linear \
    --data_dir grammar_gen_linear_data \
    --wandb_dir /nlp/scr/amirzur