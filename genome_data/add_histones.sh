#!/bin/bash
#PBS -l select=1:ncpus=1:mem=16G
#PBS -l walltime=48:00:00
#PBS -N gd_add_histone
#PBS -j oe
#PBS -W depend=afterok:425068.cherry

cd $PBS_O_WORKDIR

### STEP 4: CREATE genome data archive for segway
module load conda
conda activate segway

in_dir=.

cp segway_naive_primed.data segway_naive_primed_add_histones.data

genomedata-open-data segway_naive_primed_add_histones.data \
					 --tracknames H3K27ac H3K27me3 H3K4me1 H3K4me3
					
cat $in_dir/H3K27ac_scored.bed | genomedata-load-data segway_naive_primed_add_histones.data H3K27ac
cat $in_dir/H3K27me3_scored.bed | genomedata-load-data segway_naive_primed_add_histones.data H3K27me3
cat $in_dir/H3K4me1_scored.bed | genomedata-load-data segway_naive_primed_add_histones.data H3K4me1
cat $in_dir/H3K4me3_scored.bed | genomedata-load-data segway_naive_primed_add_histones.data H3K4me3

genomedata-close-data segway_naive_primed_add_histones.data


