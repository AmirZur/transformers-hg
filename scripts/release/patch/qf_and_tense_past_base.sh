nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_and_tense_past_s0_on_qf.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_and_tense_past_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_and_tense_past_s1_on_qf.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_and_tense_past_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_and_tense_past_s2_on_qf.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_and_tense_past_s2 checkpoint_100000.pickle'