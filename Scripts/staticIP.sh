#!/bin/bash

# Set static IP
sudo sed s/dhcp/static/ /etc/sysconfig/network-scripts/ifcfg-eth0
echo "IPADDR=192.168.1.100" >> /etc/sysconfig/network-scripts/ifcfg-eth0
sudo shutdown -r
