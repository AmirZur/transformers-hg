# tense hierarchical to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_hier_s0 checkpoint_300000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_hier_s1 checkpoint_300000.pt'

# tense linear to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_tense_hier_s0.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_linear_s0 checkpoint_300000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_tense_hier_s1.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_linear_s1 checkpoint_300000.pt'

# tense hierarchical to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_hier_s0 checkpoint_300000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_hier_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_hier_s1 checkpoint_300000.pt'

# tense linear to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_tense_linear_s0.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_linear_s0 checkpoint_300000.pt'

nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/tense_linear_to_tense_linear_s1.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_linear_s1 checkpoint_300000.pt'