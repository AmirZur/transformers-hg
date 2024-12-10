# agree (large) hierarchical to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_hier_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_lg_hier_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_hier_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_lg_hier_and_tense_s1 checkpoint_200000.pickle'

# agree (large) linear to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_linear_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_lg_linear_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_linear_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_lg_linear_and_tense_s1 checkpoint_200000.pickle'

# agree (large) hierarchical to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_hier_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_lg_hier_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_hier_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_lg_hier_and_tense_s1 checkpoint_200000.pickle'

# agree (large) linear to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_linear_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_lg_linear_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_lg_linear_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_lg_linear_and_tense_s1 checkpoint_200000.pickle'