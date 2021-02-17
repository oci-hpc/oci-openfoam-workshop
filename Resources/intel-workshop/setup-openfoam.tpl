sudo yum groupinstall -y 'Development Tools'
sudo yum -y install devtoolset-8 gcc-c++ zlib-devel openmpi openmpi-devel
%{ for i in list_suffix ~}
cd /mnt/vol${i}
wget -O - http://dl.openfoam.org/source/7 | tar xvz
wget -O - http://dl.openfoam.org/third-party/7 | tar xvz
mv OpenFOAM-7-version-7 OpenFOAM-7
mv ThirdParty-7-version-7 ThirdParty-7
export PATH=/usr/lib64/openmpi/bin/:/usr/lib64/qt5/bin/:$PATH
echo export PATH=/usr/lib64/openmpi/bin/:$PATH | sudo tee -a ~/.bashrc
echo export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib/:$LD_LIBRARY_PATH | sudo tee -a ~/.bashrc
echo source /mnt/vol${i}/OpenFOAM-7/etc/bashrc | sudo tee -a ~/.bashrc
sudo ln -s /usr/lib64/libboost_thread-mt.so /usr/lib64/libboost_thread.so
source ~/.bashrc
cd /mnt/vol${i}/OpenFOAM-7
./Allwmake -j ${num_cores} # get number of cores
%{ endfor ~}