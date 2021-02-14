sudo yum install -y mesa-libGLU
%{ for i in suffix ~}
cd /mnt/vol${i}
curl -d submit="Download" -d version="v4.4" -d type="binary" -d os="Linux" -d downloadFile="ParaView-4.4.0-Qt4-Linux-64bit.tar.gz" https://www.paraview.org/paraview-downloads/download.php > file.tar.gz
tar -xf file.tar.gz
mv ParaView-4.4.0-Qt4-Linux-64bit ParaView
%{ endfor ~}
%{ for i in suffix_or_empty ~}
echo "alias paraview${i}='/mnt/vol${i}/ParaView/bin/paraview'" >> ~/.bashrc
%{ endfor ~}