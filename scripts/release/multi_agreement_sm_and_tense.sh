# # agreement (small) hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_hier_s0.log 'bash scripts/multitask/agreement_sm_and_tense_hier.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_hier_s1.log 'bash scripts/multitask/agreement_sm_and_tense_hier.sh 1'
# # agreement (small) linear
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_linear_s0.log 'bash scripts/multitask/agreement_sm_and_tense_linear.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_linear_s1.log 'bash scripts/multitask/agreement_sm_and_tense_linear.sh 1'
# TODO: agreement (small) ambiguous
# nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_s0.log 'bash scripts/multitask/agreement_sm_and_tense.sh 0'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_s1.log 'bash scripts/multitask/agreement_sm_and_tense.sh 1'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_s2.log 'bash scripts/multitask/agreement_sm_and_tense.sh 2'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_s3.log 'bash scripts/multitask/agreement_sm_and_tense.sh 3'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_agreement_sm_and_tense_s4.log 'bash scripts/multitask/agreement_sm_and_tense.sh 4'