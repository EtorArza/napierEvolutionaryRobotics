evorl_gecco_2021="`pwd`/evorl_gecco_2021"
rsync -r -v "experiments/" "evorl_gecco_2021/experiments/"
cd $evorl_gecco_2021 
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ -DCOPPELIASIM_FOLDER=$evorl_gecco_2021/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04 -DLIMBO_FOLDER=$evorl_gecco_2021/modules/limbo -WITH_NN2=1 ..
make
sudo make install
cd ../..