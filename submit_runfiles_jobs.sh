#!/bin/sh
## Written by Andy Monaghan, Joel Johnson & Jasmine Hansen ##
## May 9th 2022 JH edit to manually add --ntasks and add max stage numbers
## JH edit aug 22 :
# use parallel flag from prep stage for stage 1 only
# add --kill-on-invalid-dep=yes to remove subsequent jobs if dependency fails.
# add array to run_16




 i=1
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=1
 id=`sbatch --export=NONE --kill-on-invalid-dep=yes --cpus-per-task=12 --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --time=24:00:00 ./runfiles_jobs_no_par.sh | awk '{print $4}'`
 echo "submitted initial job $EXE_SCRIPT as $id with $NUM_TASKS ntasks"
 
 i=2
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_02_unpack_secondary_slc | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --kill-on-invalid-dep=yes --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=3
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_03_average_baseline | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=4
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_04_extract_burst_overlaps | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amilan --kill-on-invalid-dep=yes --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2" 
 
 i=5
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_05_overlap_geo2rdr | wc -l)
 NUM_TASKS=24
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --cpus-per-task=2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=6
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_06_overlap_resample | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=7
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_07_pairs_misreg | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=8
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_08_timeseries_misreg | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2" 


## RUN 9 ARRAY ## 
 i=9
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_09_fullBurst_geo2rdr | wc -l)
 NUM_TASKS=24
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=10
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_10_fullBurst_resample | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=11
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_11_extract_stack_valid_region | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=12
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_12_merge_reference_secondary_slc | wc -l)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2" 
 
 i=13
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_13_generate_burst_igram | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=14
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_14_merge_burst_igram | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=15
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
## ARRAY_SZ=$(cat run_files/run_15_filter_coherence | wc -l)
 NUM_TASKS=12
 id2=$id
## id=`sbatch --depend=afterok:$id2  --partition=amem --qos=mem --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs.sh | awk '{print $4}'`
 id=`sbatch --depend=afterok:$id2 --export=NONE --partition=amem --qos=mem --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=16
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 ARRAY_SZ=$(cat run_files/run_16_unwrap | wc -l)
 NUM_TASKS=24
 id2=$id
 id=`sbatch --depend=afterok:$id2  --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs16.sh | awk '{print $4}'`
## id=`sbatch --depend=afterok:$id2  --partition=amilan --kill-on-invalid-dep=yes --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --time=24:00:00 --array=1-${ARRAY_SZ} ./runfiles_jobs16.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"
 




'''
 i=17
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=18
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=19
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"


 i=20
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=21
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2" 
 

 i=22
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=23
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"

 i=24
 EXE_SCRIPT=$(sed -n "${i}p" run_files/run_list)
 NUM_TASKS=12
 id2=$id
 id=`sbatch --depend=afterok:$id2 --kill-on-invalid-dep=yes --export=NONE --partition=amilan --qos=normal --account=ucb271_alpine1 --job-name=${EXE_SCRIPT} --output=${EXE_SCRIPT}_output_%j.out --nodes=1 --ntasks=${NUM_TASKS} --cpus-per-task=2 --time=24:00:00 ./runfiles_jobs.sh | awk '{print $4}'`
 echo "submited job $EXE_SCRIPT as $id with ${NUM_TASKS} ntasks, which depends on job $id2"
'''
