#!/bin/bash

# Loop through each directory and subdirectory in the current directory
find . -type d | while read -r dir; do

  # Find all *_L001_R1_001.fastq.gz files in the directory
  find "$dir" -maxdepth 1 -name '*_L001_R1_001.fastq.gz' | while read -r L001_file; do

    if [ -f "$L001_file" ]; then

      # Determine the corresponding *_L002.fastq.gz file
      L002_file="${L001_file/_L001_R1_001.fastq.gz/_L002_R1_001.fastq.gz}"

      if [ -f "$L002_file" ]; then

        # Concatenate the *_L002_R1_001.fastq.gz file to the *_L001_R1_001.fastq.gz file
        cat "$L002_file" >> "$L001_file"
        echo "Concatenated $L002_file to $L001_file."

        # Optionally, remove the *_L002.fastq.gz file after concatenation
        rm "$L002_file"

      fi
    fi
  done
done
