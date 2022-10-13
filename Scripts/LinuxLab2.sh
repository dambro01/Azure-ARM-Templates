#!/bin/bash

# Allow SELINUX to manage port [DEBUG]
# yum install -y policycoreutils-python-utils
# semanage port -a -t ssh_port_t -p tcp 22

# Disable SELinux
setenforce 0

# Update sshd_config
sed -i 's/\#Port 22/Port 2222\;/' /etc/ssh/sshd_config

# Start firewalld and enable service at system startup
systemctl start firewalld
systemctl enable firewalld

# Reboot
shutdown -r
