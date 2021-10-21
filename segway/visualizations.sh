#!/bin/bash
#PBS -l select=1:ncpus=1:mem=24G
#PBS -l walltime=48:00:00
#PBS -N segtools_hist
#PBS -j oe
#PBS -W depend=afterok:425071.cherry

cd $PBS_O_WORKDIR

module load conda
conda activate segtools

id_dir=identifydir_hist
o_dir=vis_hist

gunzip $id_dir/segway.bed.gz

time segtools-length-distribution -o $o_dir/length_distribution $id_dir/segway.bed --clobber

time segtools-signal-distribution -c chr1 -c chr2 -o $o_dir/signal_distribution \
	$id_dir/segway.bed \
	../genome_data/segway_naive_primed_add_histones.data --clobber

#time segtools-overlap --by=segments --max-contrast --clobber \
#	identifydir/segway.bed \
#	../create_genome_data_tracks/chromHMM_seg_coord_only_collapsed.bed

#time segtools-aggregation --normalize --quick --clobber --mode=region \
#	identifydir/segway.bed \
#	../create_genome_data_tracks/chromHMM_seg_coord_only_distal.bed


