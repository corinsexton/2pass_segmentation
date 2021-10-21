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


