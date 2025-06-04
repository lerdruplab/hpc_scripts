#!/bin/bash

#SBATCH --chdir=/projects/lerdrup_group/people/lwr221/analysis/epigenome_catalog/tsne_umap/     # working dir
#SBATCH --job-name=convert_to_singularity
#SBATCH --partition=marvin1                                       # partition to run in. always marvin1
#SBATCH --gres=gpu:0                                              # GPU resources requested
#SBATCH -c 6                                                      # CPU cores requested
#SBATCH --nodes=1                                                 # number of nodes
#SBATCH --time=0-72:00                                            # runtime in d-hh-:mm format
#SBATCH --mem=16gb                                                # requested total memory per node
#SBATCH --qos=low                                                 # qos sets priority
#SBATCH --mail-type=END,FAIL                                      # set email options
#SBATCH --mail-user=erkutilas@sund.ku.dk                          # set email address

module load singularity/3.8.0 #load required modules

DOCKER_IMAGE="erkutilaslan/r_tsne_umap:latest" # define docker image
SIF_NAME="r_tsne_umap.sif" # define singularity image name

singularity build "$SIF_NAME" "docker://$DOCKER_IMAGE"
