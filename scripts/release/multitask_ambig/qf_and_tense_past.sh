for seed in 1 2 3 4 5 6 7 8
do
  nlprun -g 1 -q jag -r 40G -c 3 -o logs/qf_and_tense_past_s$seed.log "bash scripts/multitask_ambig/qf_and_tense_past.sh $seed"
done