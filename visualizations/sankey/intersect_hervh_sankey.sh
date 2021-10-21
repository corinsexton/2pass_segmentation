#!/bin/bash

bedtools intersect -a ../HERVH_locus_analysis/HERVH_annotated.bed -b ../seg_naive_primed/vis_8/network.bed -f 0.25 -wa -wb > hervh_network.bed

awk -F '\t' '{print $4"\t"$10"\t"$19}' hervh_network.bed > hervh_network.tsv

sort hervh_network.tsv | uniq > hervh_network_sorted.tsv

grep -v -f ../HERVH_locus_analysis/candidate_loci_first5.txt hervh_network_sorted.tsv > noncandidate_HERVH_loci.net
grep -f ../HERVH_locus_analysis/candidate_loci_first5.txt hervh_network_sorted.tsv > andidate_HERVH_loci.net


grep -v -f /Users/coripenrod/Documents/UNLV/Year4/HERVH_locus_analysis/intersections/ChIP-STARR-seq/barakat_et_al/barakat_primed.txt hervh_network_sorted.tsv > barakat_primed_HERVH_loci.net
grep -f /Users/coripenrod/Documents/UNLV/Year4/HERVH_locus_analysis/intersections/ChIP-STARR-seq/barakat_et_al/barakat_naive.txt hervh_network_sorted.tsv > barakat_naive_HERVH_loci.net
grep -f /Users/coripenrod/Documents/UNLV/Year4/HERVH_locus_analysis/intersections/ChIP-STARR-seq/barakat_et_al/x hervh_network_sorted.tsv > barakat_diff_x.net
