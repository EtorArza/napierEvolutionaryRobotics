# Clone and cd to repo
git clone https://EtorArzaBCAM@bitbucket.org/autonomousroboticsevolution/evorl_gecco_2021.git
cd evorl_gecco_2021


sudo apt install libboost-all-dev libeigen3-dev 


evorl_gecco_2021_dir=`pwd`

cd ~/Downloads
git clone https://github.com/ci-group/MultiNEAT.git
cd MultiNEAT
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make 
sudo make install

cd ~/Downloads
git clone https://github.com/portaloffreedom/polyvox.git
cd polyvox
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make 
make install

cd ~/Downloads
git clone https://github.com/m-renaud/libdlibxx.git
cd libdlibxx
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make 
make install 

cd ~/Downloads
git clone https://github.com/beniz/libcmaes.git
cd libcmaes
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make
sudo make install


cd ~/Downloads
git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DTBB_TEST=OFF ..
make
sudo make install


cd ~/Downloads
git clone https://github.com/m-renaud/libdlibxx.git
cd libdlibxx
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make
sudo make install



cd $evorl_gecco_2021_dir
cd modules
git clone https://github.com/LeniLeGoff/nn2.git
git clone https://github.com/resibots/limbo.git
cd ..







# install CoppeliaSim Edu 4.1.0 18.04
wget -nc -c  wget -c https://www.coppeliarobotics.com/files/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz -O CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz
tar -x -k -f CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz

mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ -DCOPPELIASIM_FOLDER=$evorl_gecco_2021_dir/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04 -DLIMBO_FOLDER=$evorl_gecco_2021_dir/modules/limbo ..
make
sudo make install
