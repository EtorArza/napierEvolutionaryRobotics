# Clone and cd to repo
git clone https://EtorArzaBCAM@bitbucket.org/autonomousroboticsevolution/evolutionary_robotics_framework.git
cd evolutionary_robotics_framework


# # Install deb packages
# echo 'deb http://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/network:messaging:zeromq:release-stable.list
# curl -fsSL https://download.opensuse.org/repositories/network:messaging:zeromq:release-stable/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/network_messaging_zeromq_release-stable.gpg > /dev/null
# sudo apt update
# sudo apt install libzmq3-dev
# sudo apt install libboost-all-dev libeigen3-dev libzmq3-dev


evolutionary_robotics_framework_dir=`pwd`

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


cd ~/Downloads
git clone https://github.com/opencv/opencv.git
cd opencv
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make 
sudo make install



cd $evolutionary_robotics_framework_dir
cd modules
git clone https://github.com/LeniLeGoff/nn2.git
cd nn2
git checkout are_v2_1
cd ..
git clone https://github.com/resibots/limbo.git
cd ..


cd $evolutionary_robotics_framework_dir/modules/nn2/
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local  ..
make 
sudo make install



cd $evolutionary_robotics_framework_dir
# install CoppeliaSim Edu 4.1.0 18.04
wget -nc -c  wget -c https://www.coppeliarobotics.com/files/CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz -O CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz
tar -x -k -f CoppeliaSim_Edu_V4_1_0_Ubuntu18_04.tar.xz

cd $evolutionary_robotics_framework_dir/..
bash build.sh
