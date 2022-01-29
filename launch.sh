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
    sudo cp experiments/mnipes/parameters.csv evolutionary_robotics_framework/experiments/mnipes/parameters.csv

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

# # EXECUTE V-REP
# export LD_LIBRARY_PATH=/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04
# gdb --args ./evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04/vrep -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/nipes/parameters.csv


# EXECUTE COPPELIA
./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04/are_sim.sh simulation -h -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/mnipes/parameters.csv
