#!/bin/bash
#PBS -l select=1:ncpus=1:mem=16G
#PBS -l walltime=48:00:00
#PBS -N gd_meta
#PBS -j oe
######PBS -W depend=afterok:254600.cherry

cd $PBS_O_WORKDIR

### STEP 4: CREATE genome data archive for segway
module load conda
conda activate segway

## E10_tss_scored.bed       E14_tss_scored.bed     E18_ctcf_scored.bed       E21_repressed_scored.bed  E25_weak_scored.bed      E5_distal_scored.bed    E9_proximal_scored.bed
## E11_proximal_scored.bed  E15_tss_scored.bed     E19_dead_scored.bed       E22_weak_scored.bed       E2_repressed_scored.bed  E6_distal_scored.bed
## E12_proximal_scored.bed  E16_poised_scored.bed  E1_weak_scored.bed        E23_weak_scored.bed       E3_poised_scored.bed     E7_proximal_scored.bed
## E13_tss_scored.bed       E17_ctcf_scored.bed    E20_repressed_scored.bed  E24_gene_scored.bed       E4_proximal_scored.bed   E8_distal_scored.bed

## TOOK OVER 24 HRS (around 28 hrs on login node)

bed_dir=../create_loop_tracks/state_bedfiles_meta/scored

genomedata-load --sizes -s ../create_loop_tracks/hg38.chrom.sizes \
	-t zero=$bed_dir/0_scored.bed \
	-t one=$bed_dir/1_scored.bed \
	-t two=$bed_dir/2_scored.bed \
	-t three=$bed_dir/3_scored.bed \
	-t four=$bed_dir/4_scored.bed \
	-t five=$bed_dir/5_scored.bed \
	-t six=$bed_dir/6_scored.bed \
	-t seven=$bed_dir/7_scored.bed \
	-t eight=$bed_dir/8_scored.bed \
	-t nine=$bed_dir/9_scored.bed \
	segway_naive_primed.data


