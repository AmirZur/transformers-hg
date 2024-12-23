# hier
nlprun -a ellipse -g 1 -q jag -o logs/patch_agreement_sm_hier_and_tense_s0.log 'bash scripts/patch/agreement_sm_and_tense.sh multitask_agreement_sm_hier_and_tense_s0'
nlprun -a ellipse -g 1 -q jag -o logs/patch_agreement_sm_hier_and_tense_s1.log 'bash scripts/patch/agreement_sm_and_tense.sh multitask_agreement_sm_hier_and_tense_s1'

# linear
nlprun -a ellipse -g 1 -q jag -o logs/patch_agreement_sm_linear_and_tense_s0.log 'bash scripts/patch/agreement_sm_and_tense.sh multitask_agreement_sm_linear_and_tense_s0'
nlprun -a ellipse -g 1 -q jag -o logs/patch_agreement_sm_linear_and_tense_s1.log 'bash scripts/patch/agreement_sm_and_tense.sh multitask_agreement_sm_linear_and_tense_s1'