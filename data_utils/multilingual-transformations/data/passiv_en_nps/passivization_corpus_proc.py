import random
import argparse
from collections import Counter

parser = argparse.ArgumentParser()
parser.add_argument('--train_size', help='Size for the training set', type=int, default=100000)
parser.add_argument('--dev_size', help='Size for the dev set', type=int, default=1000)
parser.add_argument('--test_size', help='Size for the test set', type=int, default=10000)
parser.add_argument('--gen_size', help='Size for the generalization set', type=int, default=10000)
parser.add_argument('--sentences', help='File of sentences to process', type=str, default=None)
parser.add_argument('--output_prefix', help='Prefix for output file names', type=str, default=None)
args = parser.parse_args()


fi = open(args.sentences, "r")


fo_train = open(args.output_prefix +  ".train", "w")
fo_dev = open(args.output_prefix +  ".dev", "w")
fo_test = open(args.output_prefix + ".test", "w")
fo_gen = open(args.output_prefix + ".gen", "w")

# Words to delete from the sentences being processed
delList = ["N1", "N2", "N3", "N4", "N5", "N5S", "N5P", "N6", "N7", "N8", "AUX1", "AUX2", "AUX3", "AUX4", "AUX5", "AUX6", "AUX7", "AUX8", 
        "VI1", "VI2", "VI3", "VT1", "VT2", "VT3", "VT4", "VT5", "VI", "VT"]
delDict = {}
for item in delList:
    delDict[item] = 1

# convert sentence from active to passive
def passivize(sent):
    if "N5S" in sent:
        link_aux = "was"
        obj_ind = sent.index("N5S")
    else:
        link_aux = "were"
        obj_ind = sent.index("N5P")
    verb_ind = sent.index("VT3")

    #         obj NP until punctuation            main verb                       subject NP        punct
    newSent = sent[obj_ind - 1:-2] + [link_aux] + [sent[verb_ind + 1]] + ["by"] + sent[:verb_ind] + sent[-2:]
    return newSent


def process(sent):
    if sent[-1] == "passiv":
        passiv = 1
    else:
        passiv = 0

    newSent = []
    for word in sent:
        if word not in delDict:
            newSent.append(word)

    return " ".join(newSent[:-1])

count_orc = 0
count_src = 0

def get_nouns(words):
  noun_set = []
  for i, word in enumerate(words):
    if word.startswith("N"):
      noun_set.append(words[i+1])
  
  return noun_set

# Sentences we've already used (to avoid repeats)
used_dict = {}

count_train = 0
count_dev = 0
count_test = 0
count_gen = 0

count_iid = 0
count_ood = 0

iid_examples = []
ood_examples = []

filter_counts = Counter()

for line in fi:
    if count_iid >= args.train_size + args.dev_size + args.test_size and count_ood >= args.gen_size:
        break

    sent = line.strip()
    if sent in used_dict:
        continue

    used_dict[sent] = 1

    words = sent.split()
    
    nouns = get_nouns(words)
    
    
    #if len(nouns) > len(set(nouns)):
    #  filter_counts[len(nouns)] += 1
    #  continue

    if words[5] == "N2":
        pp_on_subj = 1
    else:
        pp_on_subj = 0

    passiv = random.getrandbits(1)

    if passiv:
        words.append("passiv")
    else:
        words.append("decl")

    if passiv:
        result = process(words) + " passiv" + "\t" + process(passivize(words)) + "\n"
    else:
        result = process(words) + " decl" + "\t" + process(words) + "\n"

    if (not pp_on_subj or not passiv) and count_iid < args.train_size + args.dev_size + args.test_size:
        iid_examples.append(result)
        count_iid += 1
    elif pp_on_subj and passiv and count_ood < args.gen_size:
        ood_examples.append(result)
        count_ood += 1
        count_src += 1

random.shuffle(iid_examples)
random.shuffle(ood_examples)

train_set = iid_examples[:args.train_size]
dev_set = iid_examples[args.train_size:args.train_size+args.dev_size]
test_set = iid_examples[args.train_size+args.dev_size:args.train_size+args.dev_size+args.test_size]

gen_set = ood_examples[:args.gen_size]

for elt in train_set:
    fo_train.write(elt)
for elt in dev_set:
    fo_dev.write(elt)
for elt in test_set:
    fo_test.write(elt)
for elt in gen_set:
    fo_gen.write(elt)


print(count_orc, count_src)
