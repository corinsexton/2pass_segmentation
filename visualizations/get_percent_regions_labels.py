#!/usr/bin/env python

from collections import defaultdict

# GOAL: get % of label bp that is classified in naive or primed

infile = open("vis_hist/segway.bed",'r')

infile.readline()
naive_dict = defaultdict(int)
H1_dict = defaultdict(int)

for line in infile:
	ll = line.strip().split('\t')

	bp = int(ll[2])-int(ll[1])
	label = ll[3]

	naive = 'H1' not in ll[0]

	if naive:
		naive_dict[label] += bp
	else:
		H1_dict[label] += bp

outfile = open("vis_hist/label_breakdown.tsv",'w')
outfile.write("label\tpercent_naive\tpercent_H1\tnaive_bp\tH1_bp\tall_bp\n")
for i in range(15):
	

	i_s = str(i)

	al = float(naive_dict[i_s] + H1_dict[i_s])
	if al == 0:
		continue	

	pc1 = naive_dict[i_s]/al
	pc2 = H1_dict[i_s]/al

	outfile.write(i_s + '\t' + str(pc1) + '\t' + str(pc2) + '\t' + str(naive_dict[i_s]) + '\t' + str(H1_dict[i_s]) + '\t' + str(naive_dict[i_s] + H1_dict[i_s]) + '\n')
		
