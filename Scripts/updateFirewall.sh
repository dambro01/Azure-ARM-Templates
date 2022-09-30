#!/bin/bash

# Update firewall
sudo firewall-cmd --remove-service=ssh --permanent
sudo firewall-cmd --complete-reload
