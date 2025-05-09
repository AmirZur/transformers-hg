# # question formation hierarchical to tense hierarchical
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_hier_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_hier_and_tense_s0 checkpoint_300000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_hier_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_hier_and_tense_s1 checkpoint_300000.pickle'

# # question formation linear to tense hierarchical
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_linear_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_linear_and_tense_s0 checkpoint_300000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_linear_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_linear_and_tense_s1 checkpoint_300000.pickle'

# # question formation hierarchical to tense linear
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_hier_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_hier_and_tense_s0 checkpoint_300000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_hier_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_hier_and_tense_s1 checkpoint_300000.pickle'

# # question formation linear to tense linear
# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_linear_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_linear_and_tense_s0 checkpoint_300000.pickle'

# nlprun \
#     -a ellipse -g 1 -q jag \
#     -o logs/transfer_multi_qf_linear_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_linear_and_tense_s1 checkpoint_300000.pickle'

# question formation ambiguous to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s1 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s2 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_hier_s3.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s3 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_hier_s4.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s4 checkpoint_300000.pickle'

# question formation ambiguous to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s0 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s1 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s2 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_linear_s3.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s3 checkpoint_300000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_multi_qf_to_tense_linear_s4.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/multitask_qf_and_tense_s4 checkpoint_300000.pickle'