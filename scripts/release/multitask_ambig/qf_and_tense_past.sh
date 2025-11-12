for seed in 0
do
  nlprun -g 1 -q jag -r 40G -c 3 -o logs/qf_and_tense_past_s$seed.log "bash scripts/multitask_ambig/qf_and_tense_past.sh $seed"
done