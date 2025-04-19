model=$1
checkpoint=$2

# hierarchical
python activation_patching.py \
    --model_name $model \
    --model_checkpoint $checkpoint \
    --cf_dataset_name qf \
    --num_per_generation 5 \
    --batch_size 64 \
    --seed 42 \
    --hier

# linear
python activation_patching.py \
    --model_name $model \
    --model_checkpoint $checkpoint \
    --cf_dataset_name qf \
    --num_per_generation 5 \
    --batch_size 64 \
    --seed 42