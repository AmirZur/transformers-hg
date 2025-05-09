#######################
# all tense           #
#######################
# tense formation ambiguous to agreement large hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_hier_s0.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_hier_s1.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_hier_s2.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s2 checkpoint_100000.pickle'

# tense formation ambiguous to agreement large linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_linear_s0.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_linear_s1.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r0_to_agree_sm_linear_s2.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r0_s2 checkpoint_100000.pickle'

#######################
# 50-50 agree-tense   #
#######################
# tense formation ambiguous to agreement large hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_hier_s0.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_hier_s1.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_hier_s2.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s2 checkpoint_100000.pickle'

# tense formation ambiguous to agreement large linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_linear_s0.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_linear_s1.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_tense_r50_to_agree_sm_linear_s2.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/agreement_sm_and_tense_r50_s2 checkpoint_100000.pickle'