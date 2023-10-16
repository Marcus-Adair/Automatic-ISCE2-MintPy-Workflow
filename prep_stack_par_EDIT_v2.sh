#!/bin/bash

# Original Author: Jasmine Hansen 2022 - jaha2600@colorado.edu 
# Modified by: Marcus Adair 2023 - u1131818@utah.edu

# Purpose: Used to be a Slurm script but changed to simply be a bash script to run on a personal VDC cluser
#          on the CHPC
####################################################################################################
####################################################################################################

# purge existing modules
#ml purge

# load modules (already loaded)
#module load gcc/10.3.0
gcc --version

#module load cmake/3.14.1
cmake --version

module use $HOME/MyModules
module load miniconda3/latest
conda_env="isce2"
source activate $conda_env



# select files in correct places for ion corr
# add the correct upper and lower bounds for your dataset
bounds='19.000/20.225' 
nr=10
python /uufs/chpc.utah.edu/common/home/parashar-vdc/marcus/BrieWorkflow/isce2/contrib/stack/topsStack/s1_select_ion.py -dir ./SLC/ -sn $bounds -nr $nr



# Check if the dir exists and delete it fo
##directory_name="run_files"
#if [ -d "$directory_name" ]; then
#     echo "Directory '$directory_name' exists. Deleting it ..."	
#    # Check if the directory is empty
#    if [ -n "$(find "$directory_name" -maxdepth 0 -type d -empty 2>/dev/null)" ]; then
#        # Directory is empty
#        rmdir "$directory_name"
#    else
#        # Directory is not empty
#        rm -r "$directory_name"
#    fi
#fi


ORBITS="./orbits"

#then run the stack senintel to make the run files 
# no need to have an orbits directory as it will download automatically
# need to have slc/ dem/ aux_dir/
python /uufs/chpc.utah.edu/common/home/parashar-vdc/marcus/BrieWorkflow/isce2/contrib/stack/topsStack/stackSentinel.py -s ./SLC/ -d ./DEM/dem.envi -a ./AuxDir -o ./orbits/ -b '18.900 20.250 -155.900 -154.850' -c 4 -z 1 -r 3 --param_ion ./ion_param.txt --num_connections_ion 3 --num_proc4topo 10



# Kilauea Full Island: -b '19.000 20.225 -156.000 -154.800'
# Mauna Loa= -b '19.300 19.900 -155.850 -155.350'
# move to runfiles directory
cd run_files
ls run* > run_list


# below not needed in parallel version
# add text to start of file so you know the section.
#for f in $(cat run_list) ; do sed -i "1s/^/echo '${f} START'\n/" ${f}; done
# then add the ending text to end of script.
#for i in $(cat run_list) ; do echo "echo '${i} END'" >> ${i} ; done 


# Check if run_list was made successfully
file_path="run_list"
if [ -s "$file_path" ]; then
    # Give execute permission to all run_files
    chmod +x *
    echo 'Prep Stage Complete'
else
    echo "Prep Stage Incomplete."
    echo "No run files found in run_list"
fi
cd ..


