# Moves all files and directoreis made from a ISCE2/MintPy run
# into a new directory so that the workflow can be ran again

newDirName="$1"

# Moves dirs/files made in workflow to new dir
mkdir $newDirName
mv baselines $newDirName
mv coarse_interferograms $newDirName
mv configs $newDirName
mv coreg_secondarys $newDirName
mv ESD $newDirName
mv geom_reference $newDirName
mv interferograms $newDirName
mv merged $newDirName
mv misreg $newDirName
mv reference $newDirName
mv run_files $newDirName
mv SAFE_files.txt $newDirName
mv secondarys $newDirName
mv stack $newDirName
mv isce.log $newDirName

# Move mintpy data, but keep files needed for next run
mv mintpy $newDirName
mkdir mintpy
cd $newDirName
cd mintpy
mv Hawaii.txt ../../mintpy
mv sbatch_mintpy.py ../../mintpy 
cd ../..

# Make new SLC and Orbits dirs
mv SLC $newDirName
mkdir SLC
mv orbits $newDirName
mkdir orbits
