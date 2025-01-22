#!/bin/bash

# create or clear the samplesheet.csv
echo "sample,fastq_1,fastq_2" > samplesheet.csv

# loop through each directory in the current directory
for dir in */; do

  # check if it's a directory
  if [ -d "$dir" ]; then

    # find the *.fq.gz files in the directory
    for pattern in '*R1_001.fastq.gz'; do

      R1_files=$(find "$dir" -maxdepth 1 -name "$pattern")

      for R1_file in $R1_files; do

        if [ -f "$R1_file" ]; then

          # remove the .fastq.gz extension from the R1 file
          filename=$(basename "$R1_file" .fastq.gz)

          # get the absolute path of the R1 file
          abs_path_R1=$(realpath "$R1_file")

	  # look for corresponding R2 file
	  R2_file="${R1_file/_R1_/_R2_}"

	  if [ -f "$R2_file" ]; then
            abs_path_R2=$(realpath "$R2_file")

          else
	    # if the R2 file is missing
	    abs_path_R2="NA"
	  fi

          # write the filename to samplesheet.csv
          echo "$filename,$abs_path_R1,$abs_path_R2" >> samplesheet.csv

        else

          echo "No $pattern file found in $dir."

        fi

      done

    done

  fi

done

echo "samplesheet.csv created!"

