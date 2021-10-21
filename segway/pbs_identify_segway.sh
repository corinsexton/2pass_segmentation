#!/bin/bash
#PBS -l select=1:ncpus=16:mem=64G
#PBS -l walltime=24:00:00
#PBS -N segway_id
#PBS -j oe
#PBS -W depend=afterok:425072.cherry

cd $PBS_O_WORKDIR

module load conda
conda activate segway

export SEGWAY_NUM_LOCAL_JOBS=16
export SEGWAY_CLUSTER=local

#time segway identify ../genome_data/segway_naive_primed_add_histones.data traindir_hist identifydir_hist
time segway identify ../genome_data/segway_naive_primed.data traindir identifydir
