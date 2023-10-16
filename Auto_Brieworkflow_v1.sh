#!/bin/bash
#
# Author: Marcus Adair, Sept 2023
# Modified code from Jasmine Hansen - jaha2600@colorado.edu, Andy Monaghan, Joel Johnson, and 
#
# Purpose: Automates different parts of a workflow submitted as a Slurm batch into one file to 
#	   run on a personal VDC cluster on the CHPC. 
#
##############################################################################################


# PREP:
# --------------------- #
# TODO: Automate to extract data from ASF Vertex


# TODO: Automate directories to be built if they don't already exist
#	and move files to directories


# TODO: Auto-edit (or send in as params) prep_stack_par.sh  


# Remove files from last run
#cd SLC/not_used
#rm *.zip
#cd ../..



# RUN ISCE2:
# --------------------- #
# Prep the stack of 16-24 jobs and do other ISCE configurations (prep_stack_par.sh)
# This activates the necesary Conda environment
#bash prep_stack_par_EDIT_v2.sh

# Run 16-24 ISCE2 jobs (submit_funfiles_jobs.sh)
bash submit_runfiles_jobs_EDIT_v2.sh


# PREP2:
# --------------------- #
# TODO: Collect ISCE2 results and put where necessary 

# TODO: Create mintpy dirs if necessary 

# TODO: Edit/create file for MintPy Custom template (e.g., Hawaii_Custom_Template.txt) 

# TODO: Edit sbatch_mint.py (or send in params) 




# Activate Mintpy
#conda_env="mintpy_ion"
#source activate $conda_env


# RUN MINTPY:
# --------------------- #

# TODO: Run sbatch_mintpy_EDIT_v1.py 




# POST:
# --------------------- #

# TODO: Collect, save, and organize results (compress if needed)
