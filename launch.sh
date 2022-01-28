#!/bin/bash
set -e
for i in "$@"
do
case $i in
    -b|--build)
    bash build.sh
    ;;
    -p)
    sudo cp experiments/nipes/parameters.csv evolutionary_robotics_framework/experiments/nipes/parameters.csv  
    ;;
    -l=*|--lib=*)
    DIR="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done



# logFileMountpoint="/home/paran/Dropbox/BCAM/07_estancia_1/code/logs/"
# if grep -qs "$logFileMountpoint " /proc/mounts; then
#     echo "log dir is mounted."
# else
#     echo "log dir is not mounted. Mounting..."
#     sudo mount -t tmpfs -o size=300m tmpfs $logFileMountpoint
#     echo "mounted!"
# fi


./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04/are_sim.sh simulation -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/mnipes/parameters.csv
