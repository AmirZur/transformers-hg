###################################
# tense + qf decl -> qf           #
###################################
# tense formation ambiguous to question formation hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_hier_s0.log 'bash scripts/transfer/qf_hier.sh /nlp/scr/amirzur/qf_decl_and_tense_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_hier_s1.log 'bash scripts/transfer/qf_hier.sh /nlp/scr/amirzur/qf_decl_and_tense_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_hier_s2.log 'bash scripts/transfer/qf_hier.sh /nlp/scr/amirzur/qf_decl_and_tense_s2 checkpoint_100000.pickle 0'

# tense formation ambiguous to question formation linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_linear_s0.log 'bash scripts/transfer/qf_linear.sh /nlp/scr/amirzur/qf_decl_and_tense_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_linear_s1.log 'bash scripts/transfer/qf_linear.sh /nlp/scr/amirzur/qf_decl_and_tense_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_decl_and_tense_to_qf_linear_s2.log 'bash scripts/transfer/qf_linear.sh /nlp/scr/amirzur/qf_decl_and_tense_s2 checkpoint_100000.pickle 0'