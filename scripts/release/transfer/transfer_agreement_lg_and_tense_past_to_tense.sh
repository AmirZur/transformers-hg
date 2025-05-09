##################################
# agreement + tense (past)       #
##################################
# -> tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s2 checkpoint_100000.pickle'

# -> tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_agree_lg_and_tense_past_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s2 checkpoint_100000.pickle'