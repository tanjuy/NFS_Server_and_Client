#!/usr/bin/env bash


# Variables:
NFS_server_IP=$(ip -c a | grep 'inet ' | grep -v '127' | awk '{print $2}' | head -n 1)
Blue_bold='\033[1;34m'
Normal='\033[0m'

echo "${Blue}################### NFS Server Installation ###############################${Normal}"

# Create Share File
sudo mkdir -p /exports/backup
sudo mkdir /exports/documents

# Install NFS Server
sudo apt install -y nfs-kernel-server

# Configure the NFS Server
sudo systemctl status nfs-kernel-server
sleep 3

sudo mv -v /etc/exports /etc/exports.orig

# Create a fresh /etc/exports file
sudo echo "/exports/backup $NFS_server_IP(rw,no_subtree_check)" > /etc/exports
sudo echo "/exports/documents $NFS_server_IP(rw,no_subtree_check)" >> /etc/exports


# Restart the NFS Server
sudo systemctl restart nfs-kernel-server
sudo systemctl status  nfs-kernel-server
sleep 3

# Test the NFS Server
sudo echo "Hello, I am NFS Server and in backup" > /exports/backup/test1.txt
sudo echo "Hello, I am NFS Server and in documents" > /exports/documents/test2.txt
