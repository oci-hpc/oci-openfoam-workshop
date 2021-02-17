# commands to mount block volumes

# make folders for each volume
%{ for i in list_suffix ~}
sudo mkdir -p /mnt/vol${i}
%{ endfor ~}

# make the ext4 filesystem for each volume, go with defaults
# note that the -F parameter (Force) is used to disable interactive mode.
%{ for i in list_devicepath ~}
sudo mkfs.ext4 -F ${i}
%{ endfor ~}
# for interactive mode: enter y (DOS partition table found in the device path, proceed anyway)

# see that the filsystems you create appear here
# sudo blkid

# add entries to fstab.
sudo chmod 666 /etc/fstab
sudo echo "
# block volumes
%{ for i, j in map_devicepath_suffix ~}
${i} /mnt/vol${j} ext4 defaults,_netdev,noatime 0 2
%{ endfor ~}
" >> /etc/fstab
sudo chmod 644 /etc/fstab

# mount the entries in /etc/fstab
sudo mount -a

# ssh back into the instance, and see that the drives are mounted
# sudo df -h
# sudo mount

# reboot if necessary to make sure gets mounted
# sudo reboot