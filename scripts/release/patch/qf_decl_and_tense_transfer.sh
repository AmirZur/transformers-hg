# hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s0_to_qf_hier.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s0_to_qf_hier checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s1_to_qf_hier.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s1_to_qf_hier checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s2_to_qf_hier.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s2_to_qf_hier checkpoint_100000.pickle'

# linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s0_to_qf_linear.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s0_to_qf_linear checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s1_to_qf_linear.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s1_to_qf_linear checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_qf_decl_and_tense_s2_to_qf_linear.log 'bash scripts/patch/qf.sh /nlp/scr/amirzur/qf_decl_and_tense_s2_to_qf_linear checkpoint_100000.pickle'