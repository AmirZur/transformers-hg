#######################
# all qf              #
#######################
# question formation ambiguous to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s2 checkpoint_100000.pickle 0'

# question formation ambiguous to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r100_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r100_s2 checkpoint_100000.pickle 0'

#######################
# 50-50 qf-tense      #
#######################
# question formation ambiguous to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s2 checkpoint_100000.pickle 0'

# question formation ambiguous to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_r50_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_r50_s2 checkpoint_100000.pickle 0'

#######################
# qf + tense past     #
#######################
# question formation ambiguous to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_hier_s2.log 'bash scripts/transfer/tense_hier_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s2 checkpoint_100000.pickle 0'

# question formation ambiguous to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s0 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s1 checkpoint_100000.pickle 0'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/transfer_qf_past_to_tense_linear_s2.log 'bash scripts/transfer/tense_linear_from_qf.sh /nlp/scr/amirzur/qf_and_tense_past_s2 checkpoint_100000.pickle 0'