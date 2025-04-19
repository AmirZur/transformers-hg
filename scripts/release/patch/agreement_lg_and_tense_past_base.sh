nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s0_on_agreement.log 'bash scripts/patch/agreement_lg.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s0 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s1_on_agreement.log 'bash scripts/patch/agreement_lg.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s1 checkpoint_100000.pickle'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/patch_agreement_lg_and_tense_past_s2_on_agreement.log 'bash scripts/patch/agreement_lg.sh /nlp/scr/amirzur/agreement_lg_and_tense_past_s2 checkpoint_100000.pickle'