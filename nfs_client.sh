#!/usr/bin/env bash


# Configure the NFS Client
sudo apt install nfs-comman

read -p "Enter NFS server IP(ie:192.168.1.25): " nfs_IP


# Test Server Connectivity
showmount --exports $nfs_IP


# auto-mount NFS Exports
sudo apt install autofs

sudo systemctl status autofs.service
sleep 3

# Configure autofs
sudo echo "/mnt/nfs /etc/auto.nfs --ghost --timeout=60" >> /etc/auto.master

sudo echo "backup -fstyle=nfs4,rw,$nfs_IP:/exports/backup" > /etc/auto.nfs
sudo echo "documents -fstyle=nfs4,rw,$nfs_IP:/exports/documents" >> /etc/auto.nfs

sudo systemctl restart autofs.service
sudo systemctl status autofs.service
sleep 3

printf "
df -h
mount | grep nfs
ls -l /mnt/nfs
You can check out above command line "


