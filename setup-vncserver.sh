sudo yum -y groupinstall 'Server with GUI'
sudo yum -y install tigervnc-server mesa-libGL
sudo mkdir /home/opc/.vnc/
sudo chown opc:opc /home/opc/.vnc
echo "HPC_oci1" | vncpasswd -f > /home/opc/.vnc/passwd
chown opc:opc /home/opc/.vnc/passwd
chmod 600 /home/opc/.vnc/passwd