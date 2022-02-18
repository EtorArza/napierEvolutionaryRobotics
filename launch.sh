#!/bin/bash
set -e

EXPERIMENT=""
PORT=""
CLUSTER=false
for i in "$@"
do
case $i in
    -b|--build)
    bash build.sh
    ;;
    -e=*|--experiment=*)
    EXPERIMENT="${i#*=}"
    ;;
    --cluster)
    CLUSTER=true
    ;;
    -p=*|--port=*)
    PORT="${i#*=}"
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
    echo "--cluster                when launching from napier uni cluster"
    echo "Exiting..."
    exit 1
fi


folder_in_which_launchsh_is=`pwd`
if [[ "$CLUSTER" == true ]]; then
  if [[ "$PORT" == "" ]]; then
    echo "ERROR: cluster mode requires port parameter. 
    Choose a multiple of 10000 for the port parameter. 
    Each port should only be used by each process once. Exiting..."
    exit 1
  fi
  folder_in_which_launchsh_is="/share/earza"
fi



unique_experiment_id="`date +%s`$RANDOM$RANDOM$RANDOM"
unique_experiment_name="$EXPERIMENT$unique_experiment_id"
experiment_folder="$folder_in_which_launchsh_is/evolutionary_robotics_framework/experiments/$unique_experiment_name"


# https://stackoverflow.com/questions/2129923/how-to-run-a-command-before-a-bash-script-exits
function cleanup {
  echo "Removing parameter files."
  rm -f -r $experiment_folder
}
# trap cleanup EXIT



# logFileMountpoint="/home/paran/Dropbox/BCAM/07_estancia_1/code/logs/"
# if grep -qs "$logFileMountpoint " /proc/mounts; then
#     echo "log dir is mounted."
# else
#     echo "log dir is not mounted. Mounting..."
#     sudo mount -t tmpfs -o size=300m tmpfs $logFileMountpoint
#     echo "mounted!"
# fi

mkdir $experiment_folder
cp $folder_in_which_launchsh_is/experiments/$EXPERIMENT/parameters.csv $experiment_folder/parameters.csv  
python3 scripts/utils/UpdateParameter.py -f $experiment_folder/parameters.csv -n experimentName -v "$unique_experiment_name"


# EXECUTE COPPELIA local
if [[ "$CLUSTER" == true ]]; then
  python3 scripts/utils/UpdateParameter.py -f $experiment_folder/parameters.csv -n scenePath -v "/share/earza/evolutionary_robotics_framework/experiments/sim/" --updateOnlyPath
  python3 scripts/utils/UpdateParameter.py -f $experiment_folder/parameters.csv -n robotPath -v "/share/earza/evolutionary_robotics_framework/experiments/sim/" --updateOnlyPath
  python3 scripts/utils/UpdateParameter.py -f $experiment_folder/parameters.csv -n modelPath -v "/share/earza/evolutionary_robotics_framework/experiments/sim/"
  python3 scripts/utils/UpdateParameter.py -f $experiment_folder/parameters.csv -n repository -v "/share/earza/logs"
  sbatch --job-name=earza --cpus-per-task=32 are-parallel.job $unique_experiment_name $PORT 32
else
# # EXECUTE V-REP
# export LD_LIBRARY_PATH=/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04
# gdb --args ./evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04/vrep -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/nipes/parameters.csv
  ./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04/are_sim.sh simulation -h -g$experiment_folder/parameters.csv
fi