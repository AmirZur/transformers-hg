# all agreement
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s0_r100.log 'bash scripts/multitask_ambig/qf_and_tense.sh 0 100'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s1_r100.log 'bash scripts/multitask_ambig/qf_and_tense.sh 1 100'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s2_r100.log 'bash scripts/multitask_ambig/qf_and_tense.sh 2 100'
# all tense
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s0_r0.log 'bash scripts/multitask_ambig/qf_and_tense.sh 0 0'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s1_r0.log 'bash scripts/multitask_ambig/qf_and_tense.sh 1 0'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s2_r0.log 'bash scripts/multitask_ambig/qf_and_tense.sh 2 0'
# 50-50 mix
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s0_r50.log 'bash scripts/multitask_ambig/qf_and_tense.sh 0 50'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s1_r50.log 'bash scripts/multitask_ambig/qf_and_tense.sh 1 50'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_s2_r50.log 'bash scripts/multitask_ambig/qf_and_tense.sh 2 50'