model=$1
checkpoint=$2

# hierarchical
python activation_patching.py \
    --model_name $model \
    --model_checkpoint $checkpoint \
    --cf_dataset_name agreement \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42 \
    --hier

# linear
python activation_patching.py \
    --model_name $model \
    --model_checkpoint $checkpoint \
    --cf_dataset_name agreement \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42