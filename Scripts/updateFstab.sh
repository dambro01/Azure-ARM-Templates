#!/bin/bash

# Update /etc/fstab
echo "/dev/sdc2  /mySecondPartition   auto   defaults   0   2" >> /etc/fstab
sudo shutdown -r
