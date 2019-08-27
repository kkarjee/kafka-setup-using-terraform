#!/bin/bash
# Attach the EBS volume in the console, then
# view available disks
sudo lsblk

# we verify the disk is empty - should return "data"
sudo file -s /dev/xvdh

# Note on Kafka: it's better to format volumes as xfs:
# https://kafka.apache.org/documentation/#filesystems
# Install packages to mount as xfs
sudo apt-get install -y xfsprogs

# create a partition
sudo fdisk /dev/xvdh

# format as xfs
sudo mkfs.xfs -f /dev/xvdh

# create kafka directory
sudo mkdir /data/kafka
# mount volume
sudo mount -t xfs /dev/xvdh /data/kafka
# add permissions to kafka directory
sudo chown -R ubuntu:ubuntu /data/kafka
# check it's working
df -h /data/kafka

# EBS Automount On Reboot
sudo cp /etc/fstab /etc/fstab.bak # backup
sudo echo '/dev/xvdh /data/kafka xfs defaults 0 0' >> /etc/fstab

# reboot to test actions
reboot
sudo service zookeeper start
