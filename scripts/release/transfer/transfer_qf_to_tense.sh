for seed in 0 1 2 3 4
do
  for checkpoint in 10000 30000 50000
  do
    # transfer to hierarchical
    nlprun -g 1 -q jag -r 40G -c 3 -o logs/transfer_qf_past_to_tense_hier_cp${checkpoint}_s$seed.log "bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/causal_transfer/qf_and_tense_past_s$seed $checkpoint 0"
    # transfer to linear
    nlprun -g 1 -q jag -r 40G -c 3 -o logs/transfer_qf_past_to_tense_linear_cp${checkpoint}_s$seed.log "bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/causal_transfer/qf_and_tense_past_s$seed $checkpoint 0"
  done
done