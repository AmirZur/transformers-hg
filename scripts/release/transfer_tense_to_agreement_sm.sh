# tense hierarchical to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_agree_sm_hier_s0.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/checkpoint_tense_hier_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_agree_sm_hier_s1.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/checkpoint_tense_hier_s1 checkpoint_300000.pickle'

# tense linear to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_agree_sm_hier_s0.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/checkpoint_tense_linear_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_agree_sm_hier_s1.log 'bash scripts/transfer/agreement_sm_hier.sh /nlp/scr/amirzur/checkpoint_tense_linear_s1 checkpoint_300000.pickle'

# tense hierarchical to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_agree_sm_linear_s0.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/checkpoint_tense_hier_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_agree_sm_linear_s1.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/checkpoint_tense_hier_s1 checkpoint_300000.pickle'

# tense linear to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_agree_sm_linear_s0.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/checkpoint_tense_linear_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_agree_sm_linear_s1.log 'bash scripts/transfer/agreement_sm_linear.sh /nlp/scr/amirzur/checkpoint_tense_linear_s1 checkpoint_300000.pickle'