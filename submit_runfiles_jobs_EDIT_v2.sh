#!/bin/bash
## Originally Written by Andy Monaghan, Joel Johnson & Jasmine Hansen ## 
## May 9th 2022 JH edit to manually add --ntasks and add max stage numbers

## JH edit aug 22 :
# use parallel flag from prep stage for stage 1 only
# add --kill-on-invalid-dep=yes to remove subsequent jobs if dependency fails.
# add array to run_16

## Modified by Marcus Adair u1131818@utah.edu
## September 2022

##############################################################################################################
##############################################################################################################



# The number of tasks for each job in the sequence

# For echoing details of the submitted jobs
EXE_SCRIPT=''
NUM_TASKS=''
id=''
id2=''


curStep=16



display_time() {
    local seconds=$1
    local minutes=$((seconds / 60))
    printf "%02d minutes\n" "$minutes"
}



# Function to submit a job and get the job ID
submit_job() {
	local jobID=$1
	local numTasks=$2

	echo "jobID: $jobID num_tasks: $numTasks"


	EXE_SCRIPT=$(sed -n "${jobID=}p" run_files/run_list)
	OG_EXE_SCRIPT=$EXE_SCRIPT
	

	if [ "$jobID" -eq 1 ]; then
#		echo "running runfiles_jobs_no_par on job 1"
	

		bash runfiles_job1_v1.sh $EXE_SCRIPT

		#echo 'skipping job 1 for now...'
	elif [ "$jobID" -eq 16 ]; then
		
		bash runfiles_job16_v3.sh $EXE_SCRIPT

	else
		
		bash runfiles_job2-15_v1.sh $EXE_SCRIPT $numTasks	
		
	fi


	# Set up vars for echoing out job details
	id=$OG_EXE_SCRIPT
	NUM_TASKS=$numTasks
}

# The number of tasks for each job
NUM_TASK_LIST=(1 12 12 12 24 12 12 12 24 12 12 12 12 12 12 24)


# Submit the 16 jobs
for (( ind=0; ind < ${#NUM_TASK_LIST[@]}; ind++ )); do    
    
    # index for NUM_TASK_LIST
    ID_=$((ind + 1))    	
    NUM_TASK="${NUM_TASK_LIST[ind]}"
	

 	# For going through jobs 1 at a time
    if [ "$ID_" -lt "$curStep" ]; then
	echo "Skipping job $ID_ for now ..."
		
	continue
    fi

    # Sumbit the job
    submit_job $ID_ $NUM_TASK


    if [ "$ID_" -lt "$curStep" ]; then


	# COMMENTED OUT TO SKIP JOB 1 FOR NOW FOR DEBUGGING	
	#echo "Finished initial job: $ID_ ($id) with $NUM_TASKS ntasks"        
	echo "Skipped job $ID_  "

    elif [ "$ID_" -eq 1 ]; then
	    
	    echo "Finished initial job: $ID_ ($id) with $NUM_TASKS ntasks"
		
		break # stop after job for debugging


    else
        # $i is not equal to 1
        echo "Finished job: $ID_ ($id) with $NUM_TASKS ntasks, which depends on job: $ind" 
	echo "Stopping after job: $ID_"


	break # For debugging to step through steps one by one, take this otu	

    fi  


done


