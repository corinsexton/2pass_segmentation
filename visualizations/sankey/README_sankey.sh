#!/bin/bash

#grep '_H1' segway_network_h1.bed > z
#mv z segway_network_h1.bed
#
#grep -v '_H1' segway_network.bed > z
#mv z segway_network.bed



bedtools intersect -a ../seg_n*/vis_8/segway_network.bed -b ../seg_n*/vis_8/segway_network_h1.bed -f 0.25 -F 0.25 -wa -wb > network.bed
awk -F '\t' '{print $4"\t"$13}' network.bed > network.tsv
