#!/bin/bash
# Purpose: This script submits a job on RMACC Summit. Can be used with other HPC systems if SBATCH/scheduling commands are changed.   
#SBATCH --account=ucb271_alpine1     # Summit allocation
#SBATCH --partition=amem    # Summit partition
#SBATCH --qos=mem            # Summit qos
#SBATCH --time=48:00:00           # Max wall time
#SBATCH --nodes=1          # Number of Nodes
#SBATCH --ntasks=24          # Number of tasks per job

#SBATCH --job-name=sstack-       # Job submission name
#SBATCH --mail-type=END            # Email user when job finishes
#SBATCH --mail-user= # Email address of user

#ml purge
#ml gcc/10.3.0
#ml anaconda
#conda activate mintpy_ion



# usage for normal = sbatch sbatch_mintpy.sh
smallbaselineApp.py Hawaii.txt

# ## DASK implemetnation - work in progress - needs testing
#ifgram_inversion.py inputs/ifgramStack.h5 -t smallbaselineApp.cfg
#smallbaselineApp.py smallbaselineApp.cfg

#bounding box: 18.900 20.250 -156.000 -154.800
