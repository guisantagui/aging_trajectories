#!/bin/bash -l
#Usage # sbatch [this script]
#Name of the job
#SBATCH --job-name=cr_DLPFCexp1
#SBATCH -N 1
#SBATCH --mail-user=guillem.santamaria@uni.lu
#SBATCH --mail-type=begin,end,fail
#SBATCH --ntasks-per-node=1
#SBATCH --mem=200GB
#SBATCH -c 20
#SBATCH --time=01-00:00:00
#Define sdout path
#SBATCH --output=/home/users/gsantamaria/projects/aging_trajectories/scripts/cellranger_run/output_cellranger_DLPFCexp1.txt
#Define sderr path
#SBATCH --error=/home/users/gsantamaria/projects/aging_trajectories/scripts/cellranger_run/error_cellranger_DLPFCexp1.txt
#Define the queue (Quality Of Service) to which the task shall be submitted to
#SBATCH -p bigmem
#SBATCH --qos=normal

# User variables
################################################################################

fastq_dir="/scratch/users/gsantamaria/test_larger_files/aging_trajs_data/fastq/DLPFC_exp1/"
id="DLPFC_exp1"
ref_trnscrptm="/scratch/users/gsantamaria/test_larger_files/aging_trajs_data/human_ref/refdata-gex-GRCh38-2024-A/"
out_dir="/scratch/users/gsantamaria/test_larger_files/aging_trajs_data/cell_ranger_outs/"

# Run cell ranger
################################################################################

# Create out_dir if it doesn't exist and change directory to that location
mkdir -p $out_dir
cd $out_dir

# Get sample names from the files and
samples=$(ls $fastq_dir/*_R1_*.fastq.gz | \
    sed 's|.*/||' | \
    sed 's/_R1_.*//g' | \
    sed 's/_S[0-9]\+_.*//g' | \
    sed 's/_L[0-9]*_R1_.*//g' | \
    sort | \
    uniq | \
    tr '\n' ',')
samples="${samples%,}"

cellranger count --id $id \
    --create-bam true \
    --transcriptome $ref_trnscrptm \
    --fastqs "$fastq_dir" \
    --sample $samples