# # agree (small) hierarchical to tense hierarchical
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_hier_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_hier_and_tense_s0 checkpoint_200000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_hier_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_hier_and_tense_s1 checkpoint_200000.pickle'

# # agree (small) linear to tense hierarchical
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_linear_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_linear_and_tense_s0 checkpoint_200000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_linear_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_linear_and_tense_s1 checkpoint_200000.pickle'

# # agree (small) hierarchical to tense linear
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_hier_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_hier_and_tense_s0 checkpoint_200000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_hier_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_hier_and_tense_s1 checkpoint_200000.pickle'

# # agree (small) linear to tense linear
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_linear_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_linear_and_tense_s0 checkpoint_200000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_agree_sm_linear_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_linear_and_tense_s1 checkpoint_200000.pickle'

# agree (large) ambiguous to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s1 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s2 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_hier_s3.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s3 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_hier_s4.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s4 checkpoint_200000.pickle'

# agree (large) ambiguous to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s0 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s1 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s2 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_linear_s3.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s3 checkpoint_200000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_agree_sm_to_tense_linear_s4.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/multitask_agreement_sm_and_tense_s4 checkpoint_200000.pickle'