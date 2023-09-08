#!/usr/bin/bash

# load modules and conda env
ml purge
ml gcc/10.3.0
ml gnu_parallel/20210322
ml anaconda
conda activate isce2

# get specific params for this job
WORKFILE=$SLURM_JOB_NAME
NJOBS=$SLURM_NTASKS

# run the job
echo starting ${WORKFILE}
./run_files/${WORKFILE}
echo finished ${WORKFILE}
