seed=$1

python train_transformers.py \
    --encoder_n_layers 6 \
    --callback \
    --dataset agreement_and_tense \
    --max_train_steps 100000 \
    --eval_every 1000 \
    --seed $seed \
    --tied-embedding \
    --save_every 100000 \
    --save_dir /nlp/scr/amirzur/agreement_lg_and_tense_past_s${seed} \
    --grammar agreement_hr_v4_agreement_linear_v4 \
    --wandb_dir /nlp/scr/amirzur \
    --shared_vocab tense \
    --data_dir tense_inflection_past_data