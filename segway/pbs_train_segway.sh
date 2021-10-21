#!/bin/bash
#PBS -l select=1:ncpus=16:mem=32G
#PBS -l walltime=168:00:00
#PBS -N segway
#PBS -j oe
#PBS -W depend=afterok:425068.cherry

cd $PBS_O_WORKDIR

module load conda
conda activate segway

export SEGWAY_NUM_LOCAL_JOBS=16
export SEGWAY_CLUSTER=local

# 114 hours 5 instances, 5% of genome

#time segway train ../genome_data/segway_naive_primed_add_histones.data traindir_hist \
time segway train ../genome_data/segway_naive_primed.data traindir \
				  --num-instances=10 --num-labels=10 \
				  --resolution=50 --max-train-rounds=30 \
				  --minibatch-fraction=0.10 \
				  --mixture-components 3

				  #--include-coords=../get_regions/chr1_merged.bed \

#time segway identify ../create_genome_data_tracks/chromhmm_micro-c_all_10.data traindir identifydir
