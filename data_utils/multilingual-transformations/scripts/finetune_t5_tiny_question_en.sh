#!/bin/bash

#SBATCH --job-name=MT-base-finetune
#SBATCH --nodes=1 
#SBATCH --cpus-per-task=1 
#SBATCH --mem=20GB 
#SBATCH --time=20:00:00 
#SBATCH --gres=gpu:v100:1


singularity exec --nv --overlay $SCRATCH/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda10.2-cudnn7-devel-ubuntu18.04.sif /bin/bash -c "

source /ext3/env.sh
conda activate py38

python ../models/run_seq2seq.py \
    --model_name_or_path 'google/t5-efficient-tiny' \
    --do_train \
    --task translation_src_to_tgt \
    --train_file ../data/question_have-havent_en/question_have.train.json \
    --validation_file ../data/question_have-havent_en/question_have.dev.json \
    --output_dir /scratch/am12057/t5-tiny-mccoy-finetuning-question-have-bs128/  \
    --per_device_train_batch_size=64 \
    --gradient_accumulation_steps=2 \
    --per_device_eval_batch_size=16 \
    --overwrite_output_dir \
    --predict_with_generate \
    --num_train_epochs 10.0
"
