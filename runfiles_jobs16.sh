#!/usr/bin/bash

# load modules and conda env
ml purge
ml gcc/10.3.0
ml gnu_parallel/20210322
ml anaconda
conda activate isce2

export ISCE_BASE_DIR=$ISCE_HOME
export PATH=${ISCE_BASE_DIR}/bin:${ISCE_BASE_DIR}/applications:$PATH
export PYTHONPATH=${ISCE_BASE_DIR}/local/packages:$PYTHONPATH
export PATH=$ISCE_STACK/topsStack:$PATH

# get specific params for this job
WORKFILE=$SLURM_JOB_NAME
NJOBS=$SLURM_NTASKS

# run the job
echo starting ${WORKFILE}
$(sed -n "${SLURM_ARRAY_TASK_ID}p" run_files/${WORKFILE})
echo finished ${WORKFILE}
