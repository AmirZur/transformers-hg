# agreement (small) hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/agreement_sm_hier_s0.log 'bash scripts/train/agreement_sm_hier.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_sm_hier_s1.log 'bash scripts/train/agreement_sm_hier.sh 1'
# agreement (small) linear
nlprun -a ellipse -g 1 -q jag -o logs/agreement_sm_linear_s0.log 'bash scripts/train/agreement_sm_linear.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_sm_linear_s1.log 'bash scripts/train/agreement_sm_linear.sh 1'
# TODO: agreement (small) ambiguous