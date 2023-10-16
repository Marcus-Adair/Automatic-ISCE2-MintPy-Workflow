#!/bin/bash

# Author: Marcus Adair, Sept. 2023 
#
# Purpose: Runs an ISCE2 job from a bash script as apart of a workflow

# Get the job from run_files
EXE_SCRIPT="$1"
THE_PATH="run_files/"
THE_PATH+=$EXE_SCRIPT


file_contents=$(< $THE_PATH)


#echo "In submit_files, the EXE_SCRIPT is: $EXE_SCRIPT"
#echo "File contents: $file_contents"

# Build the bash command to execute job 
COMMAND="/uufs/chpc.utah.edu/common/home/parashar-vdc/marcus/BrieWorkflow/isce2/contrib/stack/topsStack/"
COMMAND+=$file_contents

echo "The command: $COMMAND"

# Run the job
echo "Starting: $EXE_SCRIPT"
start_time=$(date +%s)

# Run job 1
python $COMMAND

end_time=$(date +%s)
elapsed_sec=$((end_time - start_time))
elapsed_minutes=$(($elapsed_sec / 60))
echo "Finished: $EXE_SCRIPT in $elapsed_minutes minutes."
