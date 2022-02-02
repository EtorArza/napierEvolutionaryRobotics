#!/bin/bash
set -e

folder_in_whic_launchsh_is="/home/paran/Dropbox/BCAM/07_estancia_1/code"

# https://stackoverflow.com/questions/2129923/how-to-run-a-command-before-a-bash-script-exits
function cleanup {
  echo "Removing parameter files."
  rm  -f "$folder_in_whic_launchsh_is/evolutionary_robotics_framework/experiments/nipes/parameters.csv"
  rm  -f "$folder_in_whic_launchsh_is/evolutionary_robotics_framework/experiments/mnipes/parameters.csv"
}
# trap cleanup EXIT


EXPERIMENT=""
for i in "$@"
do
case $i in
    -b|--build)
    bash build.sh
    ;;
    -e=*|--experiment=*)
    EXPERIMENT="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done

if [[ -z $EXPERIMENT || ( $EXPERIMENT != "nipes" && $EXPERIMENT != "mnipes" ) ]]; then
    echo "Parameter file for simulation not provided."
    echo "Example: "
    echo ""
    echo "bash launch.sh -e=nipes"
    echo ""
    echo "Parameters for launch.sh script: "
    echo "-e=experiment_name       should be either nipes or mnipes"
    echo "-b                       build before launch"
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


cp $folder_in_whic_launchsh_is/experiments/$EXPERIMENT/parameters.csv $folder_in_whic_launchsh_is/evolutionary_robotics_framework/experiments/$EXPERIMENT/parameters.csv  

# # EXECUTE V-REP
# export LD_LIBRARY_PATH=/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04
# gdb --args ./evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04/vrep -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/nipes/parameters.csv


# EXECUTE COPPELIA
./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04/are_sim.sh simulation -h -g$folder_in_whic_launchsh_is/evolutionary_robotics_framework/experiments/$EXPERIMENT/parameters.csv
