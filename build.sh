set -e
evolutionary_robotics_framework="`pwd`/evolutionary_robotics_framework"
rsync -r -v "experiments/" "evolutionary_robotics_framework/experiments/"
cd $evolutionary_robotics_framework 
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ -DCOPPELIASIM_FOLDER=$evolutionary_robotics_framework/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04 -DLIMBO_FOLDER=$evolutionary_robotics_framework/modules/limbo -WITH_NN2=1 ..
make
sudo make install
cd ../..