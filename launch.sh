#!/bin/bash
set -e
PARAM_FILE=""
for i in "$@"
do
case $i in
    -b|--build)
    bash build.sh
    ;;
    -p=*|--parameters=*)
    PARAM_FILE="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done

if [ -z $PARAM_FILE ]; then
    echo "Parameter file for simulation not provided."
    echo "Example: "
    echo ""
    echo "bash launch.sh -p=path/to/parameters.csv"
    echo ""
    echo "Parameters for launch.sh script: "
    echo "-p=path/to/parameters.csv -> parameter file path"
    echo "-b                        -> build before launch"
    echo "Exiting..."
    exit 1
fi

# logFileMountpoint="/home/paran/Dropbox/BCAM/07_estancia_1/code/logs/"
# if grep -qs "$logFileMountpoint " /proc/mounts; then
#     echo "log dir is mounted."
# else
#     echo "log dir is not mounted. Mounting..."
#     sudo mount -t tmpfs -o size=300m tmpfs $logFileMountpoint
#     echo "mounted!"
# fi

param_file_path=`realpath ${PARAM_FILE}`
echo "Launching $param_file_path"

# # EXECUTE V-REP
# export LD_LIBRARY_PATH=/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04
# gdb --args ./evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04/vrep -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/nipes/parameters.csv


# EXECUTE COPPELIA
./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04/are_sim.sh simulation -h -g$PARAM_FILE
