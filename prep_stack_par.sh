#!/bin/bash

# Written by: Jasmine Hansen 2022 - jaha2600@colorado.edu
# Purpose: This script submits a job on RMACC Summit. Can be used with other HPC systems if SBATCH/scheduling commands are changed.   
#SBATCH --account=ucb271_alpine1      # Summit allocation
#SBATCH --partition=amilan    # Summit partition
#SBATCH --time=24:00:00           # Max wall time
#SBATCH --nodes=1          # Number of Nodes
#SBATCH --ntasks=8          # Number of tasks per job

#SBATCH --job-name=sstack      # Job submission name
#SBATCH --mail-type=END            # Email user when job finishes
#SBATCH --mail-user=brco3678@colorado.edu        # Email address of user

# purge existing modules
ml purge
# load modules
ml gcc/10.3.0
ml cmake/3.14.1
ml anaconda
conda activate isce2

# select files in correct places for ion corr
# add the correct upper and lower bounds for your dataset
s1_select_ion.py -dir ./SLC -sn 19.000/20.225 -nr 10

#then run the stack senintel to make the run files 
# no need to have an orbits directory as it will download automatically
# need to have slc/ dem/ aux_dir/
stackSentinel.py -s ./SLC/ -d ./DEM/dem.envi -a ./AuxDir/ -o ./orbits/ -b '18.900 20.250 -155.900 -154.850' -c 4 -z 1 -r 3 --param_ion ./ion_param.txt --num_connections_ion 3 --num_proc4topo 10



# Kilauea Full Island: -b '19.000 20.225 -156.000 -154.800'
# Mauna Loa= -b '19.300 19.900 -155.850 -155.350'
# move to runfiles directory
cd run_files/

ls run* > run_list
# below not needed in parallel version
# add text to start of file so you know the section.
#for f in $(cat run_list) ; do sed -i "1s/^/echo '${f} START'\n/" ${f}; done
# then add the ending text to end of script.
#for i in $(cat run_list) ; do echo "echo '${i} END'" >> ${i} ; done 

echo 'Prep Stage Complete'

echo 'Need to activate run_files'
 
#chmod +x run_files/*
