#!/bin/bash

# Misconfigured NIC on Debian
sed -i 's/auto eth0/auto ens33/g' /etc/network/interfaces
shutdown -r
