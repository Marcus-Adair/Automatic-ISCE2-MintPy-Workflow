#!/bin/bash


# Author: Marcus Adair, Sept. 2023 
#
# Purpose: Runs an ISCE2 job from a bash script as apart of a workflow

# Get the job from run_files
EXE_SCRIPT="$1"
THE_PATH="run_files/"
THE_PATH+=$EXE_SCRIPT

NJOBS="$2"


# Init array of sub-tasks
COMMANDS=()


# Go over each line/sub-job in the unwrapped job and put together commands to execute them
while IFS= read -r line; do
  COMMANDS+=("$line")
done < "$THE_PATH"


# Now submit jobs and time it
echo "Starting: $EXE_SCRIPT"
start_time=$(date +%s)

# Execute jobs in parallel
# (deals with spaces in commands)
printf "%s\0" "${COMMANDS[@]}" | parallel -0 -j $NJOBS {}



end_time=$(date +%s)
elapsed_sec=$((end_time - start_time))
elapsed_minutes=$(($elapsed_sec / 60))
echo "Finished: $EXE_SCRIPT in $elapsed_minutes minutes."


