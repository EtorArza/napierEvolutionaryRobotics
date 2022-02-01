#!/bin/bash
set -e
BUILD_MODE=Release
for i in "$@"
do
case $i in
    --debug)
    echo "Building in Debug mode..."
    BUILD_MODE=Debug
    ;;
    *)
            # unknown option
    ;;
esac
done


evolutionary_robotics_framework="`pwd`/evolutionary_robotics_framework"
rsync -r -v --exclude=*.csv "experiments/" "evolutionary_robotics_framework/experiments/"

# BUILD_MODE=Debug
# BUILD_MODE=Release

cd $evolutionary_robotics_framework 
mkdir -p build
cd build
# # When using V-REP
# cmake -DONLY_SIMULATION=1 -DCOPPELIASIM_FOLDER= -DVREP_FOLDER=$evolutionary_robotics_framework/V-REP_PRO_EDU_V3_6_2_Ubuntu18_04 -DCMAKE_INSTALL_PREFIX=/usr/local/  -DLIMBO_FOLDER=$evolutionary_robotics_framework/modules/limbo -WITH_NN2=1 -DCMAKE_BUILD_TYPE=$BUILD_MODE ..

# When using Coppelia
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ -DCOPPELIASIM_FOLDER=$evolutionary_robotics_framework/CoppeliaSim_Edu_V4_3_0_Ubuntu18_04 -DLIMBO_FOLDER=$evolutionary_robotics_framework/modules/limbo -WITH_NN2=1 ..
make
sudo make install
cd ../..