#!/bin/bash


## ADD LABELS TO PRIMED CELLS (chr1_H1)
## get loop calls for primed and naive cells

#cp primed_loops.bedpe primed_loops_label.bedpe
#sort primed_loops_label.bedpe > z
#mv z primed_loops_label.bedpe
## vim :%s/chr\(\d\+\)/chr\1_H1/g
## vim :%s/chr\([\dXY]\+\)/chr\1_H1/g
#
#cut -f1-6 primed_loops_label.bedpe > x
#mv x primed_loops_label.bedpe
#cat naive_loops.bedpe primed_loops_label.bedpe > all_loops.bedpe


### get segmentation results
#cp /home/csexton/compute/naive_v_primed_segmentation/segway_np_cat/identifydir_10lab_8/segway.bed segway_run8.bed 
#
#cut -f1-4 segway_run8.bed > segway_run8_coordonly.bed



### STEP 1: Intersect loops with segmentation (segway) labels
bedtools intersect -a all_loops.bedpe -b segway_run8_coordonly.bed -wa -wb > intersect_loops_states2.bed
awk '{print $4"\t"$5"\t"$6"\t"$1"\t"$2"\t"$3}' all_loops.bedpe > loops_coord_only1.bedpe 
bedtools intersect -a loops_coord_only1.bedpe -b segway_run8_coordonly.bed -wa -wb > intersect_loops_states1.bed



### STEP 2: Create 2 bedfiles (contact 1 -> 2 and contact 2 -> 1)
cut -f 4,5,6,10 intersect_loops_states2.bed > contact2_states.bed
cut -f 4,5,6,10 intersect_loops_states1.bed > contact1_states.bed



#### STEP 3: SEPARATE AND SCORE BY STATE
mkdir state_bedfiles_meta
mkdir state_bedfiles_meta/scored

## FIX HEADER HERE
#cut -f4 segway_run8_coordonly.bed | sort | uniq > classes_meta.txt

while read -r state; do

	grep -P "\t$state$" contact2_states.bed > state_bedfiles_meta/${state}.bed
	grep -P "\t$state$" contact1_states.bed >> state_bedfiles_meta/${state}.bed

	bedtools sort -i state_bedfiles_meta/${state}.bed > z
	bedtools merge -i z > x

	awk '{print $1"\t"$2"\t"$3"\t1"}' x > state_bedfiles_meta/scored/${state}_scored.bed
	bedtools sort -i state_bedfiles_meta/scored/${state}_scored.bed > z
	mv z state_bedfiles_meta/scored/${state}_scored.bed

	bedtools complement -i state_bedfiles_meta/scored/${state}_scored.bed -g hg38.chrom.sizes > z
	awk '{print $1"\t"$2"\t"$3"\t0"}' z >> state_bedfiles_meta/scored/${state}_scored.bed

	bedtools sort -i state_bedfiles_meta/scored/${state}_scored.bed > z
	mv z state_bedfiles_meta/scored/${state}_scored.bed

done < classes_meta.txt



### STEP 4: CREATE genome data archive for segway
#module load conda
#conda activate segway
#
#pip install genomedata


# E10_tss_scored.bed       E14_tss_scored.bed     E18_ctcf_scored.bed       E21_repressed_scored.bed  E25_weak_scored.bed      E5_distal_scored.bed    E9_proximal_scored.bed
# E11_proximal_scored.bed  E15_tss_scored.bed     E19_dead_scored.bed       E22_weak_scored.bed       E2_repressed_scored.bed  E6_distal_scored.bed
# E12_proximal_scored.bed  E16_poised_scored.bed  E1_weak_scored.bed        E23_weak_scored.bed       E3_poised_scored.bed     E7_proximal_scored.bed
# E13_tss_scored.bed       E17_ctcf_scored.bed    E20_repressed_scored.bed  E24_gene_scored.bed       E4_proximal_scored.bed   E8_distal_scored.bed

### TOOK OVER 24 HRS (around 28 hrs on login node)

#genomedata-load --sizes -s hg38.chrom.sizes \
#	-t E10_tss=state_bedfiles/scored/E10_tss_scored.bed \
#	-t E11_proximal=state_bedfiles/scored/E11_proximal_scored.bed \
#	-t E12_proximal=state_bedfiles/scored/E12_proximal_scored.bed \
#	-t E13_tss=state_bedfiles/scored/E13_tss_scored.bed \
#	-t E14_tss=state_bedfiles/scored/E14_tss_scored.bed \
#	-t E15_tss=state_bedfiles/scored/E15_tss_scored.bed \
#	-t E16_poised=state_bedfiles/scored/E16_poised_scored.bed \
#	-t E17_ctcf=state_bedfiles/scored/E17_ctcf_scored.bed \
#	-t E18_ctcf=state_bedfiles/scored/E18_ctcf_scored.bed \
#	-t E19_dead=state_bedfiles/scored/E19_dead_scored.bed \
#	-t E1_weak=state_bedfiles/scored/E1_weak_scored.bed \
#	-t E20_repressed=state_bedfiles/scored/E20_repressed_scored.bed \
#	-t E21_repressed=state_bedfiles/scored/E21_repressed_scored.bed \
#	-t E22_weak=state_bedfiles/scored/E22_weak_scored.bed \
#	-t E23_weak=state_bedfiles/scored/E23_weak_scored.bed \
#	-t E24_gene=state_bedfiles/scored/E24_gene_scored.bed \
#	-t E25_weak=state_bedfiles/scored/E25_weak_scored.bed \
#	-t E2_repressed=state_bedfiles/scored/E2_repressed_scored.bed \
#	-t E3_poised=state_bedfiles/scored/E3_poised_scored.bed \
#	-t E4_proximal=state_bedfiles/scored/E4_proximal_scored.bed \
#	-t E5_distal=state_bedfiles/scored/E5_distal_scored.bed \
#	-t E6_distal=state_bedfiles/scored/E6_distal_scored.bed \
#	-t E7_proximal=state_bedfiles/scored/E7_proximal_scored.bed \
#	-t E8_distal=state_bedfiles/scored/E8_distal_scored.bed \
#	-t E9_proximal=state_bedfiles/scored/E9_proximal_scored.bed \
#	chromhmm_micro-c.data
#
#
