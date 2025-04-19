#################
# QF            #
#################
# hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_scratch_to_qf_hier.log 'bash scripts/transfer/qf_hier_from_scratch.sh'


# linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_scratch_to_qf_linear.log 'bash scripts/transfer/qf_linear_from_scratch.sh'

#################
# Tense         #
#################
# hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_scratch_to_tense_hier.log 'bash scripts/transfer/tense_hier_from_scratch.sh'

# linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_scratch_to_tense_linear.log 'bash scripts/transfer/tense_linear_from_scratch.sh'