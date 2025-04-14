# default mix (something like 60-40 qf-tense)
nlprun -a ellipse -g 1 -q jag -o logs/qf_decl_and_tense_s0.log 'bash scripts/multitask_ambig/qf_decl_and_tense.sh 0'
nlprun -a ellipse -g 1 -q jag -o logs/qf_decl_and_tense_s1.log 'bash scripts/multitask_ambig/qf_decl_and_tense.sh 1'
nlprun -a ellipse -g 1 -q jag -o logs/qf_decl_and_tense_s2.log 'bash scripts/multitask_ambig/qf_decl_and_tense.sh 2'