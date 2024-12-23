model=$1

# patch on same task (hierarchical)
python activation_patching.py \
    --model_name /nlp/scr/amirzur/$model \
    --model_checkpoint checkpoint_200000.pickle \
    --cf_dataset_name agreement \
    --g_name agreement_hr \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42 \
    --hier

# patch on same task (linear)
python activation_patching.py \
    --model_name /nlp/scr/amirzur/$model \
    --model_checkpoint checkpoint_200000.pickle \
    --cf_dataset_name agreement \
    --g_name agreement_hr \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42 \

# patch on transfer task (hierarchical)
python activation_patching.py \
    --model_name /nlp/scr/amirzur/$model \
    --model_checkpoint checkpoint_200000.pickle \
    --cf_dataset_name tense \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42 \
    --hier

# patch on transfer task (linear)
python activation_patching.py \
    --model_name /nlp/scr/amirzur/$model \
    --model_checkpoint checkpoint_200000.pickle \
    --cf_dataset_name tense \
    --num_per_generation 10 \
    --batch_size 64 \
    --seed 42 \