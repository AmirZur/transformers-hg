# # question formation hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_hier_and_tense_s0.log 'bash scripts/multitask/qf_hier_and_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_hier_and_tense_s1.log 'bash scripts/multitask/qf_hier_and_tense.sh 1'
# # question formation linear
nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_linear_and_tense_s0.log 'bash scripts/multitask/qf_linear_and_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_linear_and_tense_s1.log 'bash scripts/multitask/qf_linear_and_tense.sh 1'
# TODO: question formation ambiguous
# nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_and_tense_s0.log 'bash scripts/multitask/qf_and_tense.sh 0'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_and_tense_s1.log 'bash scripts/multitask/qf_and_tense.sh 1'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_and_tense_s2.log 'bash scripts/multitask/qf_and_tense.sh 2'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_and_tense_s3.log 'bash scripts/multitask/qf_and_tense.sh 3'
# nlprun -a ellipse -g 1 -q jag -o logs/multi_qf_and_tense_s4.log 'bash scripts/multitask/qf_and_tense.sh 4'