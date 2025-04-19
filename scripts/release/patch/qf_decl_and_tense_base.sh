nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s0_on_tense.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/qf_decl_and_tense_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s1_on_tense.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/qf_decl_and_tense_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s2_on_tense.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/qf_decl_and_tense_s2 checkpoint_100000.pickle'