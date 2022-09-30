#!/bin/bash

# Update sshd_config
echo "/dev/sdc2  /mySecondPartition   auto   defaults   0   2" >> /etc/ssh/sshd_config
sudo shutdown -r
