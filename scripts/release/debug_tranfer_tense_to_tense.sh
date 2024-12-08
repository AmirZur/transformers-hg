# tense hierarchical to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/debug_tense_hier_to_tense_hier.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_hier_debug checkpoint_300000.pt'

# tense linear to tense hierarchical
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/debug_tense_linear_to_tense_hier.log 'bash scripts/transfer/tense_hier.sh /nlp/scr/amirzur/checkpoint_tense_linear_debug checkpoint_300000.pt'

# tense hierarchical to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/debug_tense_hier_to_tense_linear.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_hier_debug checkpoint_300000.pt'

# tense linear to tense linear
nlprun \
    -a ellipse -g 1 -q jag \
    -o logs/debug_tense_linear_to_tense_linear.log 'bash scripts/transfer/tense_linear.sh /nlp/scr/amirzur/checkpoint_tense_linear_debug checkpoint_300000.pt'