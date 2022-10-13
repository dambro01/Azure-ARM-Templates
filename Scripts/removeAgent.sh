#!/bin/bash

# Remove WALinuxAgent
(sleep 20 && sudo yum -y remove WALinuxAgent) &
