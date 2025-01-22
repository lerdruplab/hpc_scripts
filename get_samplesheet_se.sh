#!/bin/bash

# create or clear the samplesheet.csv
echo "sample,fastq_1" > samplesheet.csv

# loop through each directory in the current directory
for dir in */; do

  # check if it's a directory
  if [ -d "$dir" ]; then

    # find the *_R1_001.fastq.gz and *_R1_002.fastq.gz files in the directory
    for pattern in '*_R1_001.fastq.gz'; do

      files=$(find "$dir" -maxdepth 1 -name "$pattern")

      for file in $files; do

        if [ -f "$file" ]; then

          # remove the .fastq.gz extension from the file
          filename=$(basename "$file" .fastq.gz)

          # get the absolute path of the file
          abs_path=$(realpath "$file")

          # write the filename to samplesheet.csv
          echo "$filename,$abs_path" >> samplesheet.csv

        else

          echo "No $pattern file found in $dir."

        fi

      done

    done

  fi

done

echo "samplesheet.csv created!"

