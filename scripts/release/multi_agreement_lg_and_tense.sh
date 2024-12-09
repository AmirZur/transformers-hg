# agreement (large) hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_hier_to_tense_s0.log 'bash scripts/train/agreement_lg_hier_to_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_hier_to_tense_s1.log 'bash scripts/train/agreement_lg_hier_to_tense.sh 1'
# agreement (large) linear
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_linear_to_tense_s0.log 'bash scripts/train/agreement_lg_linear_to_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_linear_to_tense_s1.log 'bash scripts/train/agreement_lg_linear_to_tense.sh 1'
# TODO: agreement (large) ambiguous