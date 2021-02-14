%{ for i in suffix ~}
# make new directory for the motorbike workshop
mkdir -p /mnt/vol${i}/work
cd /mnt/vol${i}/work
# get motorbike_RDMA.tgz from Santa Monica
wget https://oraclesantamonica.github.io/hpc/scripts/motorbike_RDMA.tgz
tar -xf motorbike_RDMA.tgz
# get the motorBike folder from tutorial
cp -r /mnt/vol${i}/OpenFOAM-7/tutorials/incompressible/simpleFoam/motorBike .
# This sed syntax works for Linux
# remove references to hostfile
sed -i 's/-machinefile hostfile //g' Allrun
source /mnt/vol/${i}/OpenFOAM-7/etc/bashrc
./Allrun ${num_cores}
%{ endfor ~}