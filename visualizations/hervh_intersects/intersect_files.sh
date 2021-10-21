#!/bin/bash


bedtools intersect -a ../../HERVH_locus_analysis/HERVH_annotated.bed -b ../vis/segway.bed -wa -wb > vis_HERVH.bed
bedtools intersect -a ../../HERVH_locus_analysis/HERVH_annotated.bed -b ../vis_hist/segway.bed -wa -wb > vis_hist_HERVH.bed

# CREATE H1 labelled hervh bed
#:%s/\(chr[\dXY]\+\)\t/\1_H1\t/

bedtools intersect -a HERVH_annotated_H1.bed -b ../vis/segway.bed -wa -wb > vis_HERVH_H1.bed
bedtools intersect -a HERVH_annotated_H1.bed -b ../vis_hist/segway.bed -wa -wb > vis_hist_HERVH_H1.bed

./get_label_distribution.py vis_HERVH.bed vis_HERVH_H1.bed vis_hervh_summary.tsv vis_hervh_elements.tsv
./get_label_distribution.py vis_hist_HERVH.bed vis_hist_HERVH_H1.bed vis_hist_hervh_summary.tsv vis_hist_hervh_elements.tsv
