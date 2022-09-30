#!/bin/bash

set -o pipefail

# Update Grub
sudo rm -f /boot/efi/EFI/redhat/grub.cfg
sudo rm -f /boot/grub2/grub.cfg
sudo shutdown -r
