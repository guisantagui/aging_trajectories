#!/bin/bash -l
#Usage # sbatch [this script]
#Name of the job
#SBATCH --job-name=dl_DLPFCexp1
#SBATCH -N 1
#SBATCH --mail-user=guillem.santamaria@uni.lu
#SBATCH --mail-type=begin,end,fail
#SBATCH --ntasks-per-node=1
#SBATCH --mem=10GB
#SBATCH -c 4
#SBATCH --time=00-01:00:00
#Define sdout path
#SBATCH --output=/home/users/gsantamaria/projects/aging_trajectories/scripts/synapse_downloads/output_dl_DLPFCexp1.txt
#Define sderr path
#SBATCH --error=/home/users/gsantamaria/projects/aging_trajectories/scripts/synapse_downloads/error_dl_DLPFCexp1.txt
#Define the queue (Quality Of Service) to which the task shall be submitted to
#SBATCH -p batch
#SBATCH --qos=normal

conda activate python-3.8
# User variables
################################################################################
synID="syn17055069"
out_dir="/scratch/users/gsantamaria/test_larger_files/aging_trajs_data/fastq/DLPFC_exp1/"

# Download files
################################################################################
python3 download_synapse.py --synID $synID --outDir $out_dir

# Rename files to make them CellRanger ready
################################################################################
samples=$(ls $out_dir/*_R1_*.fastq.gz | sed 's|.*/||' | sed 's/_L[0-9]*_R1_.*//g' | sort | uniq)

dl_files=$(ls $out_dir/*_R1_*.fastq.gz)


for sample in $samples; do
    # Find all matching files for this sample
    for file in $(find $out_dir -name "${sample}_L00*"); do
        # Extract the sample
        samp=$(echo "$file" | cut -d'-' -f3)

        if [[ $samp != S* ]]; then
            samp="S$samp"
        fi

        # Extract lane and read info
        lane_read=$(echo "$file" | grep -o '_L00[0-9]_.*')


        # Construct new filename with S value
        new_name="${sample}_${samp}${lane_read}"
        # Rename file
        mv "$file" "${out_dir}${new_name}"
    done
done


conda deactivate