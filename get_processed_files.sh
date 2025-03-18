#!/bin/bash

# create or clear the samplesheet.csv
echo "sample,bed_file" > bedsheet.csv

# loop through each directory in the current directory
for dir in */; do

  # check if it's a directory
  if [ -d "$dir" ]; then

    # find the *.fq.gz files in the directory
    for pattern in '*.bed'; do

      bed_files=$(find "$dir" -maxdepth 1 -name "$pattern")

      for bed_file in $bed_files; do

        if [ -f "$bed_file" ]; then

          # remove the .bed extension from the bed file
          filename=$(basename "$bed_file" .bed)

          # get the absolute path of the R1 file
          abs_path_bed=$(realpath "$bed_file")

          # write the filename to samplesheet.csv
          echo "$filename,$abs_path_bed" >> bedsheet.csv

        else

          echo "No $pattern file found in $dir."

        fi

      done

    done

  fi

done

echo "bedsheet.csv created!"
