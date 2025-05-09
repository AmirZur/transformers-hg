import os
from collections import defaultdict
from typing import List
import random
import numpy as np

from pcfg import PCFG
from parse_q_and_tense import pos_to_parse, pos_to_parse_tense, convert_to_parse

def index(lst, item, default=-1):
    """
    Index function with optional default value
    """
    try:
        return lst.index(item)
    except ValueError:
        return default

def flatten(l):
    for el in l:
        if isinstance(el, tuple):
            yield from flatten(el)
        else:
            yield el

def get_rel_clause_indices(parse):
    if parse[-1] == '.':
        parse = parse[0]
    np = parse[0][0]
    rel = parse[0][1]

    rel_start = len(list(flatten(np)))
    rel_end = rel_start + len(list(flatten(rel)))
    return rel_start, rel_end

def get_matrix_verb_index_tense(parse):
    if parse[-1] == '.':
        parse = parse[0]

    # get main verb: 1st child of 2nd child of root
    before_verb = parse[0]
    before_verb = list(flatten(before_verb))
    return len(before_verb)

def generate_from_cfg(cfg, start):
    if start not in cfg:
        return [[start.strip()]] #, [[]]
    else:
        expansions = []
        # parse_trees = []
        for production in cfg[start]:
            expansion = [[]]
            # parse_tree = [[f"{start} -> {' '.join(production).strip()}"]]
            for symbol in production:
                expansions_curr = generate_from_cfg(cfg, symbol)
                # expansions_curr, parse_trees_curr = zip(*expansions_curr)
                expansion = [
                    x + y for x in expansion for y in expansions_curr
                ]
                # parse_tree = [x + y for x in parse_tree for y in parse_trees_curr]
            expansions.extend(expansion)
            # parse_trees.extend(parse_tree)
        return expansions #, parse_trees

def sample_cf_subject_tense(
    sentence : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the subject noun changes (sg -> pl, pl -> sg)

    This dataset is used to test hierarchical grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse_tense(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of subject noun & matrix verb (only edits made)
    subject_noun_idx = min(
        index(sentence, 'N_sg', default=len(sentence)),
        index(sentence, 'N_pl', default=len(sentence))
    )
    assert 0 <= subject_noun_idx < len(sentence), "Can't find the subject noun"
    matrix_verb_idx = get_matrix_verb_index_tense(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[subject_noun_idx] = sg_to_pl[cf_sentence[subject_noun_idx]]
    cf_sentence[matrix_verb_idx] = sg_to_pl[cf_sentence[matrix_verb_idx]]

    # all other verbs should follow the linear rule: match # of nearest noun
    for w in range(len(cf_sentence)):
        if w == matrix_verb_idx:
            # linear rule doesn't apply to matrix verb
            continue
        # for each verb, find the nearest noun to its left
        if sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    # note: we flipped the subject noun, so it's inverted
                    if n == subject_noun_idx and sentence[w].split('_')[-1] == sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    elif n != subject_noun_idx and sentence[w].split('_')[-1] != sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'noun_index': subject_noun_idx,
        'base_matrix_verb_index': matrix_verb_idx,
        'source_matrix_verb_index': matrix_verb_idx,
        'cf_label': cf_sentence[matrix_verb_idx],
        'base_label': base_sentence[matrix_verb_idx]
    }

def sample_cf_recent_tense(
    sentence : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the recent noun 
    (right-most noun to left of matrix verb) changes (sg -> pl, pl -> sg)

    This dataset is used to test linear grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse_tense(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of matrix verb and its most recent noun (closest to it from the right)
    matrix_verb_idx = get_matrix_verb_index_tense(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"
    recent_noun_idx = -1
    for n in range(matrix_verb_idx - 1, -1, -1):
        if sentence[n].startswith('N'):
            recent_noun_idx = n
            break
    assert 0 <= recent_noun_idx < len(sentence), "Can't find the most recent noun"

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[recent_noun_idx] = sg_to_pl[cf_sentence[recent_noun_idx]]
    cf_sentence[matrix_verb_idx] = sg_to_pl[cf_sentence[matrix_verb_idx]]

    # all other verbs should follow the linear rule: match # of nearest noun
    for w in range(len(cf_sentence)):
        if w == matrix_verb_idx:
            # already flipped matrix verb, so no need to flip again
            continue
        # for each verb, find the nearest noun to its left
        if sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    # note: we flipped the subject noun, so it's inverted
                    if n == recent_noun_idx and sentence[w].split('_')[-1] == sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    elif n != recent_noun_idx and sentence[w].split('_')[-1] != sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'noun_index': recent_noun_idx,
        'base_matrix_verb_index': matrix_verb_idx,
        'source_matrix_verb_index': matrix_verb_idx,
        'cf_label': cf_sentence[matrix_verb_idx],
        'base_label': base_sentence[matrix_verb_idx]
    }

def sample_cf_rel_linear_tense(
    sentence : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the recent noun 
    (right-most noun to left of matrix verb) changes (sg -> pl, pl -> sg)

    This dataset is used to test linear grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse_tense(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of matrix verb and its most recent noun (closest to it from the right)
    matrix_verb_idx = get_matrix_verb_index_tense(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"
    # get index of subject noun & matrix verb (only edits made)
    subject_noun_idx = min(
        index(sentence, 'N_sg', default=len(sentence)),
        index(sentence, 'N_pl', default=len(sentence))
    )
    assert 0 <= subject_noun_idx < len(sentence), "Can't find the most recent noun"

    # break ambiguity by changing subject from sg -> pl/ pl -> sg
    base_sentence[subject_noun_idx] = sg_to_pl[base_sentence[subject_noun_idx]]
    ref_sentence = sentence.copy() # update reference sentence as well
    ref_sentence[subject_noun_idx] = sentence[subject_noun_idx][:-2] + ('sg' if sentence[subject_noun_idx].endswith('pl') else 'pl')

    # create counterfactual by moving rel clause to the end of the sentence
    rel_start, rel_end = get_rel_clause_indices(parse)
    cf_sentence = base_sentence[:rel_start] + base_sentence[rel_end:-1] + base_sentence[rel_start:rel_end] + [base_sentence[-1]] # make sure to keep "." at the end
    cf_ref_sentence = ref_sentence[:rel_start] + ref_sentence[rel_end:-1] + ref_sentence[rel_start:rel_end] + [ref_sentence[-1]] # update reference sentence as well

    # make sure everything follows the linear rule
    for w in range(len(base_sentence)):
        # for each verb, find the nearest noun to its left
        if ref_sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if ref_sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    if ref_sentence[w].split('_')[-1] != ref_sentence[n].split('_')[-1]:
                        base_sentence[w] = sg_to_pl[base_sentence[w]]
                    break

    # repeat for cf sentence
    for w in range(len(cf_sentence)):
        # for each verb, find the nearest noun to its left
        if cf_ref_sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if cf_ref_sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    if cf_ref_sentence[w].split('_')[-1] != cf_ref_sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_matrix_verb_index': matrix_verb_idx,
        'source_matrix_verb_index': rel_start,
        'cf_label': cf_sentence[rel_start],
        'base_label': base_sentence[matrix_verb_idx]
    }

def sample_cf_rel_hier_tense(
    sentence : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the recent noun 
    (right-most noun to left of matrix verb) changes (sg -> pl, pl -> sg)

    This dataset is used to test linear grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse_tense(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of matrix verb and its most recent noun (closest to it from the right)
    matrix_verb_idx = get_matrix_verb_index_tense(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"
    # get index of subject noun & matrix verb (only edits made)
    subject_noun_idx = min(
        index(sentence, 'N_sg', default=len(sentence)),
        index(sentence, 'N_pl', default=len(sentence))
    )
    assert 0 <= subject_noun_idx < len(sentence), "Can't find the most recent noun"

    # break ambiguity by changing subject from sg -> pl/ pl -> sg
    base_sentence[subject_noun_idx] = sg_to_pl[base_sentence[subject_noun_idx]]
    ref_sentence = sentence.copy() # update reference sentence as well
    ref_sentence[subject_noun_idx] = sentence[subject_noun_idx][:-2] + ('sg' if sentence[subject_noun_idx].endswith('pl') else 'pl')

    # create counterfactual by moving rel clause to the end of the sentence
    rel_start, rel_end = get_rel_clause_indices(parse)
    cf_sentence = base_sentence[:rel_start] + base_sentence[rel_start + 1:rel_end] + [base_sentence[rel_start]] + base_sentence[rel_end:] # make sure to keep "." at the end
    cf_ref_sentence = ref_sentence[:rel_start] + ref_sentence[rel_start + 1:rel_end] + [ref_sentence[rel_start]] + ref_sentence[rel_end:] # update reference sentence as well

    base_matrix_verb_index = matrix_verb_idx
    source_matrix_verb_index = rel_start # main verb is where relative clause used to start

    # update matrix verbs in both sentences
    base_sentence[base_matrix_verb_index] = sg_to_pl[base_sentence[base_matrix_verb_index]]
    cf_sentence[source_matrix_verb_index] = sg_to_pl[cf_sentence[source_matrix_verb_index]]

    # make sure everything EXCEPT MATRIX VERB follows the linear rule
    for w in range(len(base_sentence)):
        if w == base_matrix_verb_index:
            # linear rule doesn't apply to matrix verb
            continue
        # for each verb, find the nearest noun to its left
        if ref_sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if ref_sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    if ref_sentence[w].split('_')[-1] != ref_sentence[n].split('_')[-1]:
                        base_sentence[w] = sg_to_pl[base_sentence[w]]
                    break

    # repeat for cf sentence
    for w in range(len(cf_sentence)):
        if w == source_matrix_verb_index:
            # linear rule doesn't apply to matrix verb
            continue
        # for each verb, find the nearest noun to its left
        if cf_ref_sentence[w].startswith('V'):
            for n in range(w - 1, -1, -1):
                if cf_ref_sentence[n].startswith('N'):
                    # if verb and noun don't match in number, change verb
                    if cf_ref_sentence[w].split('_')[-1] != cf_ref_sentence[n].split('_')[-1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break
    
    # use base matrix verb index for labels 
    # because matrix verb is different across sentences and it's hard to compare
    # but we can compare the number on the verb that's the matrix verb in the base sentence (and not in the cf sentence)
    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_matrix_verb_index': base_matrix_verb_index,
        'source_matrix_verb_index': base_matrix_verb_index,
        'cf_label': cf_sentence[base_matrix_verb_index],
        'base_label': base_sentence[base_matrix_verb_index]
    }

def preprocess_example_tense(
    example : dict,
    present_to_past : dict
):
    """
    Preprocess input for the model
    Input: present tense sentence, ends in .
    Output: past tense sentence . PRESENT\tpresent tense sentence .
    """
    base, source = example['base'], example['source']

    def to_past(sentence):
        if sentence[-1] != '.':
            sentence.append('.')
        return [present_to_past[w] if w in present_to_past else w for w in sentence]
    
    base_past, source_past = to_past(base), to_past(source)

    # sentence is repeated, so get both indices (shifted by sentence + 'PRESENT')
    # noun_idxs = [example['noun_index'], example['noun_index'] + len(base) + 1]
    base_matrix_verb_index = example['base_matrix_verb_index'] + len(base) + 1
    source_matrix_verb_index = example['source_matrix_verb_index'] + len(source) + 1
    last_token_index = len(base_past) + 1 # indexes PRESENT

    base = " ".join(base_past + ['PRESENT'] + base)
    source = " ".join(source_past + ['PRESENT'] + source)

    # two for one deal: can swap base & source to test inverse value of intervened variable
    base_to_source = {
        'base': base,
        'source': source,
        'base_matrix_verb_index': base_matrix_verb_index,
        'source_matrix_verb_index': source_matrix_verb_index,
        'cf_label': example['cf_label'],
        'base_label': example['base_label'],
        'last_token_index': last_token_index
    }

    source_to_base = {
        'base': source,
        'source': base,
        'base_matrix_verb_index': source_matrix_verb_index,
        'source_matrix_verb_index': base_matrix_verb_index,
        'cf_label': example['base_label'],
        'base_label': example['cf_label'],
        'last_token_index': last_token_index
    }

    return [base_to_source, source_to_base]

def tense_cf(
    num_per_generation : int = 2,
    hier : bool = False,
    seed : int = 0,
    rel : bool = False, # whether to intervene on relative clause or not
    verbose : bool = True
):
    # set random seed
    random.seed(seed)
    np.random.seed(seed)

    tense_gr = defaultdict(list)
    if rel and hier:
        gr_path = 'data_utils/cfgs/tense_cf_rel_hier.gr'
    elif rel: # linear
        gr_path = 'data_utils/cfgs/tense_cf_rel_linear.gr'
    else:
        gr_path = 'data_utils/cfgs/tense_cf.gr'
    with open(gr_path) as f:
        for line in f:
            # skip empty lines and comments
            if line.strip() != '' and not line.strip().startswith('#'):
                prob, key, cont = line.strip().split('\t')
                prob = float(prob)
                tense_gr[key].append((prob, cont.strip()))

    tense_cfg = defaultdict(list)
    for key, conts in tense_gr.items():
        for prob, cont in conts:
            tense_cfg[key].append(cont.split())

    templates = generate_from_cfg(tense_cfg, 'ROOT')
    print(f'Loaded {len(templates)} templates')

    pos_to_token = defaultdict(list)
    with open('data_utils/cfgs/tense_pos_to_token.tsv') as f:
        for line in f:
            if line.strip() == '':
                continue
            _, pos, token = line.strip().split('\t')
            pos_to_token[pos].append(token)
    
    sg_to_pl = dict()
    with open('data_utils/cfgs/tense_sg_to_pl.tsv') as f:
        for line in f:
            if line.strip() == '':
                continue
            sg, pl = line.strip().split('\t')
            sg_to_pl[sg] = pl
            sg_to_pl[pl] = sg

    present_to_past = dict()
    with open('data_utils/cfgs/tense_present_to_past.tsv') as f:
        for line in f:
            if line.strip() == '':
                continue
            pres, past = line.strip().split('\t')
            present_to_past[pres] = past
    
    cf_dataset = []
    for template in templates:
        for _ in range(num_per_generation):
            if rel and hier:
                sampled_cf = sample_cf_rel_hier_tense(template, pos_to_token, sg_to_pl)
            elif rel: # linear
                sampled_cf = sample_cf_rel_linear_tense(template, pos_to_token, sg_to_pl)
            elif hier:
                sampled_cf = sample_cf_subject_tense(template, pos_to_token, sg_to_pl)
            else:
                sampled_cf = sample_cf_recent_tense(template, pos_to_token, sg_to_pl)
            example = preprocess_example_tense(sampled_cf, present_to_past)
            cf_dataset.extend(example) # two for one deal
        
    print(f'Generated {len(cf_dataset)} examples')

    if verbose:
        example = cf_dataset[0]
        print('Example (index 0):')
        print('Base:', example['base'])
        print('Base verb:', example['base'].split()[example['base_matrix_verb_index']])
        print('Source:', example['source'])
        print('Source verb:', example['source'].split()[example['source_matrix_verb_index']])

    return cf_dataset

def get_matrix_verb_index_agreement(parse):
    verb = parse[1][0]
    if isinstance(verb, list):
        verb = verb[0]
    _, verb_index = verb
    return verb_index 

def tree_to_parse_agreement(tree : List[str], run_assertions : bool = True):
    tree_ds = {}
    for l in tree:
        start = l.split('->')[0].strip()
        continuation = l.split('->')[1].strip()
        # make sure that nodes are unique
        # by adding marker ID
        start = start + '#0'
        while start in tree_ds:
            start = start.split('#')[0] + '#' + str(int(start.split('#')[1]) + 1)
        tree_ds[start] = continuation
        
    reconstructed_sentence = []
    seen = set()
    def to_parse(tree_ds, node):
        node = node + '#0'
        while node in seen:
            node = node.split('#')[0] + '#' + str(int(node.split('#')[1]) + 1)
        seen.add(node)
        if node not in tree_ds:
            # copy current value so result doesn't update
            curr_len = len(reconstructed_sentence) 
            node = node.split('#')[0] # remove ID for display
            reconstructed_sentence.append(node)
            return (node, curr_len)
        result = []
        for n in tree_ds[node].split():
            result.append(to_parse(tree_ds, n))
        return result
    
    parse = to_parse(tree_ds, 'S')
    if run_assertions:
        return parse, reconstructed_sentence
    return parse

def sample_cf_recent_agreement(
    template : List[str], 
    tree : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the recent noun 
    (right-most noun to left of matrix verb) changes (sg -> pl, pl -> sg)

    This dataset is used to test linear grammar understanding in the model
    """
    parse, _ = tree_to_parse_agreement(tree)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in template:
        assert p in pos_to_token, f"Part-of-speech can't be decoded: {p}"
        base_sentence.append(np.random.choice(pos_to_token[p]))
    
    # get index of matrix verb 
    matrix_verb_idx = get_matrix_verb_index_agreement(parse)
    assert 0 <= matrix_verb_idx < len(template), "Can't find the matrix verb"
    # get index of most recent noun to the left of the matrix verb
    recent_noun_idx = -1
    for n in range(matrix_verb_idx - 1, -1, -1):
        if template[n].startswith('n_'):
            recent_noun_idx = n
            break
    assert 0 <= recent_noun_idx < len(template), "Can't find the most recent noun"

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[recent_noun_idx] = sg_to_pl[cf_sentence[recent_noun_idx]]
    cf_sentence[matrix_verb_idx] = sg_to_pl[cf_sentence[matrix_verb_idx]]

    # all other verbs should follow the linear rule: match # of nearest noun
    for w in range(len(cf_sentence)):
        if w == matrix_verb_idx:
            # already flipped matrix verb, so no need to flip again
            continue
        # for each verb, find the nearest noun to its left
        if template[w].startswith('v_'):
            for n in range(w - 1, -1, -1):
                if template[n].startswith('n_'):
                    # if verb and noun don't match in number, change verb
                    # note: we flipped the subject noun, so it's inverted
                    if n == recent_noun_idx and template[w].split('_')[1] == template[n].split('_')[1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    elif n != recent_noun_idx and template[w].split('_')[1] != template[n].split('_')[1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break

    return {
        'base': " ".join(base_sentence),
        'source': " ".join(cf_sentence),
        'noun_indices': [recent_noun_idx],
        'matrix_verb_index': matrix_verb_idx,
        'cf_label': cf_sentence[matrix_verb_idx],
        'base_label': base_sentence[matrix_verb_idx]
    }

def sample_cf_subject_agreement(
    template : List[str], 
    tree : List[str],
    pos_to_token : dict,
    sg_to_pl : dict
):
    """
    Create counterfactual pair where only the subject noun 
    left-most noun changes (sg -> pl, pl -> sg)

    This dataset is used to test linear grammar understanding in the model
    """
    parse, _ = tree_to_parse_agreement(tree)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in template:
        assert p in pos_to_token, f"Part-of-speech can't be decoded: {p}"
        base_sentence.append(np.random.choice(pos_to_token[p]))
    
    # get index of matrix verb 
    matrix_verb_idx = get_matrix_verb_index_agreement(parse)
    assert 0 <= matrix_verb_idx < len(template), "Can't find the matrix verb"
    # get index of subject noun (left-most noun)
    subject_noun_idx = -1
    for n in range(matrix_verb_idx): # must be before matrix verb
        if template[n].startswith('n_'):
            subject_noun_idx = n
            break
    assert 0 <= subject_noun_idx < len(template), "Can't find the subject noun"

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[subject_noun_idx] = sg_to_pl[cf_sentence[subject_noun_idx]]
    cf_sentence[matrix_verb_idx] = sg_to_pl[cf_sentence[matrix_verb_idx]]

    # all other verbs should follow the linear rule: match # of nearest noun
    for w in range(len(cf_sentence)):
        if w == matrix_verb_idx:
            # already flipped matrix verb, so no need to flip again
            continue
        # for each verb, find the nearest noun to its left
        if template[w].startswith('v_'):
            for n in range(w - 1, -1, -1):
                if template[n].startswith('n_'):
                    # if verb and noun don't match in number, change verb
                    # note: we flipped the subject noun, so it's inverted
                    if n == subject_noun_idx and template[w].split('_')[1] == template[n].split('_')[1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    elif n != subject_noun_idx and template[w].split('_')[1] != template[n].split('_')[1]:
                        cf_sentence[w] = sg_to_pl[cf_sentence[w]]
                    break

    return {
        'base': " ".join(base_sentence),
        'source': " ".join(cf_sentence),
        'noun_indices': [subject_noun_idx],
        'matrix_verb_index': matrix_verb_idx,
        'cf_label': cf_sentence[matrix_verb_idx],
        'base_label': base_sentence[matrix_verb_idx]
    }

def agreement_cf(
    g_type : str = "CFG-CNF",
    g_name : str = "agreement_hr_v4",
    num_per_generation : int = 2,
    hier : bool = False,
    seed : int = 0,
    run_assertions : bool = True,
    verbose : bool = True
):
    # set random seed
    random.seed(seed)
    np.random.seed(seed)

    pfcg = PCFG(g_type, filename=os.path.join("cfgs", g_name + ".gr"))
    templates, trees = pfcg.generate()
    print(f'Loaded {len(templates)} templates')

    if run_assertions:
        # make sure we correctly reconstructed sentences
        for template, tree in zip(templates, trees):
            _, reconstructed = tree_to_parse_agreement(tree, run_assertions=True)
            assert template.split() == reconstructed, f"Reconstructed sentence doesn't match template: {template} vs {reconstructed}"
        
        # make sure that we're fetching the right matrix verb
        for idx in range(len(trees)):
            parse, _ = tree_to_parse_agreement(trees[idx])
            verb = parse[1][0]
            if isinstance(verb, list):
                verb = verb[0]
            v, v_i = verb

            assert v == templates[idx].split()[v_i], f"Matrix verb doesn't match: {v} vs {templates[idx].split()[v_i]}"
            assert v.startswith('v'), f"Matrix verb is not a verb: {v}"

    cf_templates = []
    for template, tree in zip(templates, trees):
        parse = tree_to_parse_agreement(tree, run_assertions=False)
        verb_index = get_matrix_verb_index_agreement(parse)
        nouns = [w for w in template.split()[:verb_index] if w[0].startswith('n')]
        # filter to ambiguous examples: recent & subject nouns should have the same #
        if len(nouns) == 2 and nouns[0] == nouns[1]:
            cf_templates.append((template, tree))
    print(f'Filtered to {len(cf_templates)} counterfactual templates')

    pos_to_token = defaultdict(list)
    with open('cfgs/tag_token_map.txt') as f:
        for line in f:
            if line.strip() != '':
                pos, token = line.strip().split()
                pos_to_token[pos.strip()].append(token.strip())

    sg_to_pl = dict()
    with open('cfgs/agreement_sg_to_pl.tsv') as f:
        for line in f:
            if line.strip() != '':
                pl, sg = line.strip().split()
                sg_to_pl[pl.strip()] = sg.strip()
                sg_to_pl[sg.strip()] = pl.strip()

    cf_dataset = []
    for gen, tree in cf_templates:
        for _ in range(num_per_generation):
            if hier:
                example = sample_cf_subject_agreement(gen.split(), tree, pos_to_token, sg_to_pl)
            else:
                example = sample_cf_recent_agreement(gen.split(), tree, pos_to_token, sg_to_pl)
            cf_dataset.append(example)
        
    print(f'Generated {len(cf_dataset)} examples')

    if verbose:
        example = cf_dataset[0]
        print('Example (index 0):')
        print('Base:', example['base'])
        print('Base subject:', example['base'].split()[example['noun_indices'][0]])
        print('Base verb:', example['base'].split()[example['matrix_verb_index']])
        print('Source:', example['source'])
        print('Source subject:', example['source'].split()[example['noun_indices'][0]])
        print('Source verb:', example['source'].split()[example['matrix_verb_index']])

    return cf_dataset

def get_matrix_verb_index_qf(parse):
    return get_matrix_verb_index_tense(parse) + 1

def sample_cf_main_qf(
    sentence : List[str],
    pos_to_token : dict,
    pos_to_neg : dict
):
    """
    Create counterfactual pair where the main auxiliary changes (neg -> pos, pos -> neg)

    This dataset is used to test hierarchical grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of subject noun & matrix verb (only edits made)
    matrix_verb_idx = get_matrix_verb_index_qf(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"
    main_aux_idx = matrix_verb_idx - 1

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[main_aux_idx] = pos_to_neg[cf_sentence[main_aux_idx]]

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_aux_idx': main_aux_idx,
        'source_aux_idx': main_aux_idx
    }

def sample_cf_first_qf(
    sentence : List[str],
    pos_to_token : dict,
    pos_to_neg : dict
):
    """
    Create counterfactual pair where the first auxiliary changes (neg -> pos, pos -> neg)

    This dataset is used to test hierarchical grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of subject noun & matrix verb (only edits made)
    first_aux_idx = min(
        index(sentence, 'Aux_S', default=len(sentence)),
        index(sentence, 'Aux_P', default=len(sentence)),
        index(sentence, 'Aux_S_Neg', default=len(sentence)),
        index(sentence, 'Aux_P_Neg', default=len(sentence)),
    )
    assert 0 <= first_aux_idx < len(sentence), "Can't find the first auxiliary"

    cf_sentence = base_sentence.copy()
    # make subject & matrix verb sg -> pl/ pl -> sg
    cf_sentence[first_aux_idx] = pos_to_neg[cf_sentence[first_aux_idx]]

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_aux_idx': first_aux_idx,
        'source_aux_idx': first_aux_idx
    }

def sample_cf_rel_hier_qf(
    sentence : List[str],
    pos_to_token : dict,
    pos_to_neg : dict
):
    """
    Create counterfactual pair where the relative word moves to the end of the relative clause
    (the zebra THAT doesn't like the yak does eat -> the zebra doesn't like the yak THAT does eat)

    This dataset is used to test hierarchical grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of subject noun & matrix verb (only edits made)
    matrix_verb_idx = get_matrix_verb_index_qf(parse)
    assert 0 <= matrix_verb_idx < len(sentence), "Can't find the matrix verb"
    main_aux_idx = matrix_verb_idx - 1
    
    # break ambiguity by making subject & matrix verb sg -> pl/ pl -> sg
    base_sentence[main_aux_idx] = pos_to_neg[base_sentence[main_aux_idx]]

    # move rel to the end of the rel phrase
    # e.g. the newt WHO does like your cat doesn't swim -> the newt does like your cat WHO doesn't swim
    rel_start, rel_end = get_rel_clause_indices(parse)
    cf_sentence = base_sentence.copy()
    cf_sentence = cf_sentence[:rel_start] + cf_sentence[rel_start + 1:rel_end] + [cf_sentence[rel_start]] + cf_sentence[rel_end:]

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_aux_idx': main_aux_idx, # index of aux on base stays the same
        'source_aux_idx': rel_start, # index of aux on source changes to aux in rel clause
    }

def sample_cf_rel_linear_qf(
    sentence : List[str],
    pos_to_token : dict,
    pos_to_neg : dict
):
    """
    Create counterfactual pair where the entire relative clause moves to the end of the sentence
    (e.g., the zebra [that does eat] doesn't like the yack -> the zebra doesn't like the yak [that does eat])

    This dataset is used to test hierarchical grammar understanding in the model
    """
    pos = [w[0] if w != '.' else 'T' for w in sentence]
    parse = convert_to_parse(" ".join(sentence), pos_to_parse(pos), do_postprocess=False)

    # fill in sentence with randomly chosen tokens for each POS
    base_sentence = []
    for p in sentence:
        if p in pos_to_token:
            base_sentence.append(np.random.choice(pos_to_token[p]))
        else:
            base_sentence.append(p)
    
    # get index of subject noun & matrix verb (only edits made)
    first_aux_idx = min(
        index(sentence, 'Aux_S', default=len(sentence)),
        index(sentence, 'Aux_P', default=len(sentence)),
        index(sentence, 'Aux_S_Neg', default=len(sentence)),
        index(sentence, 'Aux_P_Neg', default=len(sentence)),
    )
    assert 0 <= first_aux_idx < len(sentence), "Can't find the first auxiliary"

    # break ambiguity by changing first aux sg -> pl/ pl -> sg
    base_sentence[first_aux_idx] = pos_to_neg[base_sentence[first_aux_idx]]

    # move entire rel clause to the end of the sentence
    # e.g. the zebra [that does eat] doesn't like the yack . -> the zebra doesn't like the yak [that does eat] .
    rel_start, rel_end = get_rel_clause_indices(parse)
    cf_sentence = base_sentence[:rel_start] + base_sentence[rel_end:-1] + base_sentence[rel_start:rel_end] + [base_sentence[-1]] # make sure to keep "." at the end

    return {
        'base': base_sentence,
        'source': cf_sentence,
        'base_aux_idx': first_aux_idx, # index of aux on base stays the same
        'source_aux_idx': rel_start, # main aux is what gets left behind after rel clause moves
    }

def preprocess_example_qf(
    example : dict,
):
    """
    Preprocess input for the model
    Input: present tense sentence, ends in .
    Output: past tense sentence . quest\tpresent tense sentence .
    """
    base, source = example['base'], example['source']

    def to_question(sentence, aux_idx):
        # move aux to front
        if sentence[-1] != '.':
            sentence.append('.')
        question = [sentence[aux_idx]] + sentence[:aux_idx] + sentence[aux_idx + 1:]
        return question

    # we want to compare which auxiliary was moved to the front (first thing following "quest")
    cf_logit_index = len(base) + 1
    last_token_index = len(base) + 1 # indexes quest (left-shifted from logits!)

    base = base + ['quest'] + to_question(base, example['base_aux_idx'])
    source = source + ['quest'] + to_question(source, example['source_aux_idx'])

    # two for one deal: can swap base & source to test inverse value of intervened variable
    source_to_base = {
        'base': " ".join(base),
        'source': " ".join(source),
        'base_matrix_verb_index': cf_logit_index,
        'source_matrix_verb_index': cf_logit_index,
        'cf_label': source[cf_logit_index],
        'base_label': base[cf_logit_index],
        'last_token_index': last_token_index
    }

    base_to_source = {
        'base': " ".join(source),
        'source': " ".join(base),
        'base_matrix_verb_index': cf_logit_index,
        'source_matrix_verb_index': cf_logit_index,
        'cf_label': base[cf_logit_index],
        'base_label': source[cf_logit_index],
        'last_token_index': last_token_index
    }

    return [source_to_base, base_to_source]

def qf_cf(
    num_per_generation : int = 2,
    hier : bool = False,
    seed : int = 0,
    rel : bool = False, # whether to intervene on relative clause or not
    verbose : bool = True
):
    # set random seed
    random.seed(seed)
    np.random.seed(seed)

    qf_gr = defaultdict(list)
    if rel and hier:
        gr_path = 'data_utils/cfgs/qf_cf_rel_hier.gr'
    elif rel: # linear
        gr_path = 'data_utils/cfgs/qf_cf_rel_linear.gr'
    else:
        gr_path = 'data_utils/cfgs/qf_cf.gr'
    with open(gr_path) as f:
        for line in f:
            # skip empty lines and comments
            if line.strip() != '' and not line.strip().startswith('#'):
                prob, key, cont = line.strip().split('\t')
                prob = float(prob)
                qf_gr[key].append((prob, cont.strip()))

    qf_cfg = defaultdict(list)
    for key, conts in qf_gr.items():
        for prob, cont in conts:
            qf_cfg[key].append(cont.split())

    templates = generate_from_cfg(qf_cfg, 'ROOT')
    print(f'Loaded {len(templates)} templates')

    pos_to_token = defaultdict(list)
    with open('data_utils/cfgs/qf_pos_to_token.tsv') as f:
        for line in f:
            if line.strip() == '':
                continue
            _, pos, token = line.strip().split('\t')
            pos_to_token[pos].append(token)
    
    pos_to_neg = {
        'does': 'doesn\'t',
        'doesn\'t': 'does',
        'do': 'don\'t',
        'don\'t': 'do',
    }
    
    cf_dataset = []
    for template in templates:
        for _ in range(num_per_generation):
            if rel and hier:
                sampled_cf = sample_cf_rel_hier_qf(template, pos_to_token, pos_to_neg)
            elif rel: # linear
                sampled_cf = sample_cf_rel_linear_qf(template, pos_to_token, pos_to_neg)
            elif hier:
                sampled_cf = sample_cf_main_qf(template, pos_to_token, pos_to_neg)
            else:
                sampled_cf = sample_cf_first_qf(template, pos_to_token, pos_to_neg)
            example_pair = preprocess_example_qf(sampled_cf) # note: this returns two examples (base -> source and source -> base)
            cf_dataset.extend(example_pair)
        
    print(f'Generated {len(cf_dataset)} examples')

    if verbose:
        example = cf_dataset[0]
        print('Example (index 0):')
        print('Base:', example['base'])
        print('Base aux:', example['base'].split()[example['base_matrix_verb_index']])
        print('Source:', example['source'])
        print('Source aux:', example['source'].split()[example['source_matrix_verb_index']])

    return cf_dataset