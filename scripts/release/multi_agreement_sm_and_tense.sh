# agreement (small) hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_hier_and_tense_s0.log 'bash scripts/multitask/agreement_sm_hier_and_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_hier_and_tense_s1.log 'bash scripts/multitask/agreement_sm_hier_and_tense.sh 1'
# agreement (small) linear
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_linear_and_tense_s0.log 'bash scripts/multitask/agreement_sm_linear_and_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_linear_and_tense_s1.log 'bash scripts/multitask/agreement_sm_linear_and_tense.sh 1'
# TODO: agreement (small) ambiguous