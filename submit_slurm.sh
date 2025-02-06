#!/bin/bash

#SBATCH --chdir=/projects/lerdrup_group/people/lwr221/analysis/bdk4me3_esc_ipsc/     # working dir
#SBATCH --job-name=chip_mapping                                   # job name
#SBATCH --partition=marvin1                                       # partition to run in. always marvin1
#SBATCH --gres=gpu:0                                              # GPU resources requested
#SBATCH -c 32                                                     # CPU cores requested
#SBATCH --nodes=1                                                 # number of nodes
#SBATCH --time=0-72:00                                            # runtime in d-hh-:mm format
#SBATCH --mem=64gb                                                # requested total memory per node
#SBATCH --qos=low                                                 # qos sets priority
#SBATCH --mail-type=END,FAIL                                      # set email options
#SBATCH --mail-user=erkutilas@sund.ku.dk                          # set email address

module load openjdk/20.0.0 nextflow/23.04.1.5866 singularity/3.8.0 #load required modules

nextflow run /projects/lerdrup_group/people/lwr221/pipelines/ew-qctrimalign \
    -profile marvinUCPH,singularity \
    --aligner bowtie1 \
    --input /projects/lerdrup_group/people/lwr221/analysis/bdk4me3_esc_ipsc/samplesheet.csv \
    --outdir /projects/lerdrup_group/people/lwr221/analysis/bdk4me3_esc_ipsc/outdir_k4me3/ \
    --index /projects/lerdrup_group/people/lwr221/indexes/mm10/index/bowtie_canonical/ \
    -resume
