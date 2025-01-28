# default mix (something like 60-40 qf-tense)
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_past_s0_r50.log 'bash scripts/multitask_ambig/qf_and_tense_past.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_past_s1_r50.log 'bash scripts/multitask_ambig/qf_and_tense_past.sh 1'
nlprun -a ellipse -g 1 -q jag -o logs/qf_and_tense_past_s2_r50.log 'bash scripts/multitask_ambig/qf_and_tense_past.sh 2'