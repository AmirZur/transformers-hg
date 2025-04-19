# hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s0_to_tense_hier.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s0_to_tense_hier checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s1_to_tense_hier.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s1_to_tense_hier checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s2_to_tense_hier.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s2_to_tense_hier checkpoint_100000.pickle'

# linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s0_to_tense_linear.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s0_to_tense_linear checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s1_to_tense_linear.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s1_to_tense_linear checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s2_to_tense_linear.log 'base scripts/patch/tense.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s2_to_tense_linear checkpoint_100000.pickle'