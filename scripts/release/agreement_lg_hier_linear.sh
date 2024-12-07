# agreement (large) hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_hier_s0.log 'bash scripts/train/agreement_lg_hier.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_hier_s1.log 'bash scripts/train/agreement_lg_hier.sh 1'
# agreement (large) linear
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_linear_s0.log 'bash scripts/train/agreement_lg_linear.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/agreement_lg_linear_s1.log 'bash scripts/train/agreement_lg_linear.sh 1'