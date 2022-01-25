bash build.sh

# logFileMountpoint="/home/paran/Dropbox/BCAM/07_estancia_1/code/logs/"
# if grep -qs "$logFileMountpoint " /proc/mounts; then
#     echo "log dir is mounted."
# else
#     echo "log dir is not mounted. Mounting..."
#     sudo mount -t tmpfs -o size=300m tmpfs $logFileMountpoint
#     echo "mounted!"
# fi


./evolutionary_robotics_framework/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04/are_sim.sh simulation -h -g/home/paran/Dropbox/BCAM/07_estancia_1/code/evolutionary_robotics_framework/experiments/nipes/parameters.csv
