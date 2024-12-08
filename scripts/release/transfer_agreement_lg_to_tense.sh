# agree (large) hierarchical to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_hier_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_agreement_lg_hier_s0 checkpoint_200000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_hier_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_agreement_lg_hier_s1 checkpoint_200000.pt'

# agree (large) linear to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_linear_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_agreement_lg_linear_s0 checkpoint_200000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_linear_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_agreement_lg_linear_s1 checkpoint_200000.pt'

# agree (large) hierarchical to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_hier_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_agreement_lg_hier_s0 checkpoint_200000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_hier_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_agreement_lg_hier_s1 checkpoint_200000.pt'

# agree (large) linear to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_linear_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_agreement_lg_s0 checkpoint_200000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/agree_lg_linear_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_agreement_lg_s1 checkpoint_200000.pt'