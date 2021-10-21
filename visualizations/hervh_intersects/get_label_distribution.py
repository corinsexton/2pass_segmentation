#!/usr/bin/env python
import sys
from collections import defaultdict

infile = open(sys.argv[1], 'r')

soloDict = defaultdict(set)
flDict = defaultdict(set)
nonflDict = defaultdict(set)
Dict_3 = defaultdict(set)
Dict_5 = defaultdict(set)

for line in infile:
	ll = line.strip().split()

	hervh = ll[3].split(':')
	seg_label = ll[9]

	if hervh[0] == 'solo':
		soloDict[seg_label].add(hervh[2])
	elif hervh[0] == 'nonflanked':
		nonflDict[seg_label].add(hervh[2])
		if hervh[3] == '3prime':
			Dict_3[seg_label].add(hervh[2])
		else:
			Dict_5[seg_label].add(hervh[2])
	else:
		flDict[seg_label].add(hervh[2])

infile = open(sys.argv[2], 'r')

soloDict_H1 = defaultdict(set)
flDict_H1 = defaultdict(set)
nonflDict_H1 = defaultdict(set)
Dict_3_H1 = defaultdict(set)
Dict_5_H1 = defaultdict(set)

for line in infile:
	ll = line.strip().split()

	hervh = ll[3].split(':')
	seg_label = ll[9]

	if hervh[0] == 'solo':
		soloDict_H1[seg_label].add(hervh[2])
	elif hervh[0] == 'nonflanked':
		nonflDict_H1[seg_label].add(hervh[2])
		if hervh[3] == '3prime':
			Dict_3_H1[seg_label].add(hervh[2])
		else:
			Dict_5_H1[seg_label].add(hervh[2])
	else:
		flDict_H1[seg_label].add(hervh[2])


outfile = open(sys.argv[3],'w')

outfile.write("label\tnum_total\tnum_solo\tnum_flanked\tnum_nonflanked\t3prime\t5prime\n")

for i in range(15):
	i_s = str(i)
	solo = len(soloDict[i_s])
	fl = len(flDict[i_s])
	nonfl = len(nonflDict[i_s])

	prime3 = len(Dict_3[i_s])
	prime5 = len(Dict_5[i_s])
	
	outfile.write('naive_' + i_s + '\t' + str(solo + fl + nonfl) + '\t' + str(solo) + '\t' + str(fl) + '\t' + str(nonfl) + '\t' + str(prime3) + '\t' + str(prime5) + '\n')

for i in range(15):
	i_s = str(i)
	solo = len(soloDict_H1[i_s])
	fl = len(flDict_H1[i_s])
	nonfl = len(nonflDict_H1[i_s])

	prime3 = len(Dict_3_H1[i_s])
	prime5 = len(Dict_5_H1[i_s])
	
	outfile.write('H1_' + i_s + '\t' + str(solo + fl + nonfl) + '\t' + str(solo) + '\t' + str(fl) + '\t' + str(nonfl) + '\t' + str(prime3) + '\t' + str(prime5) + '\n')



outfile2 = open(sys.argv[4],'w')

outfile2.write("label\telements\n")

for i in range(15):
	i_s = str(i)
	outfile2.write('naive_' + str(i) + '\t' + ':'.join(soloDict[i_s]) + ':' + ':'.join(flDict[i_s]) + ':' + ':'.join(nonflDict[i_s]) + '\n')

for i in range(15):
	i_s = str(i)
	outfile2.write('H1_' + str(i) + '\t' + ':'.join(soloDict_H1[i_s]) + ':' + ':'.join(flDict_H1[i_s]) + ':' + ':'.join(nonflDict_H1[i_s]) + '\n')

