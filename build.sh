evorl_gecco_2021_dir="/home/paran/Dropbox/BCAM/07_estancia_1/code/evorl_gecco_2021"
cd $evorl_gecco_2021_dir 
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ -DCOPPELIASIM_FOLDER=$evorl_gecco_2021_dir/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04 -DLIMBO_FOLDER=$evorl_gecco_2021_dir/modules/limbo ..
make
sudo make install
cd ../..