# tense inflection hierarchical
nlprun -a ellipse -g 1 -q jag -o logs/tense_hier_s0.log 'bash scripts/train/tense_hier.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/tense_hier_s1.log 'bash scripts/train/tense_hier.sh 1'
# tense inflection linear
nlprun -a ellipse -g 1 -q jag -o logs/tense_linear_s0.log 'bash scripts/train/tense_linear.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/tense_linear_s1.log 'bash scripts/train/tense_linear.sh 1'