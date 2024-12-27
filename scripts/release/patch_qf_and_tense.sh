# # hier
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_hier_and_tense_s0.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_hier_and_tense_s0'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_hier_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_hier_and_tense_s1'

# # linear
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_linear_and_tense_s0.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_linear_and_tense_s0'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_linear_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_linear_and_tense_s1'

# ambiguous
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_and_tense_s0.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_and_tense_s0'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_and_tense_s1'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_and_tense_s2'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_and_tense_s3'
nlprun -a ellipse -g 1 -q jag -o logs/patch_qf_and_tense_s1.log 'bash scripts/patch/qf_and_tense.sh multitask_qf_and_tense_s4'