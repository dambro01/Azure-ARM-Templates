#!/bin/bash

set -o pipefail
date | tee -a /tmp/scriptResults.txt

# mounting attached windows drive
mkdir /datadrive | tee -a /tmp/scriptResults.txt
partition=$(lsblk -f -i -l | grep Windows | grep -o '^sd\w*\b')
echo "$partition" | tee -a /tmp/scriptResults.txt

# https://docs.fedoraproject.org/en-US/epel/#How_can_I_use_these_extra_packages.3F
sudo subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms | tee -a /tmp/scriptResults.txt
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y | tee -a /tmp/scriptResults.txt

# https://access.redhat.com/solutions/23993
sudo yum install ntfs-3g -y | tee -a /tmp/scriptResults.txt

# [root@rhelVM RYMCCALL]# mount /dev/sdc4 /datadrive
# The disk contains an unclean file system (0, 0).
# Metadata kept in Windows cache, refused to mount.
# Falling back to read-only mount because the NTFS partition is in an
# unsafe state. Please resume and shutdown Windows fully (no hibernation
# or fast restarting.)
# Could not mount read-write, trying read-only
# ^^^ Fixing above error ^^^
sudo yum install ntfsprogs -y | tee -a /tmp/scriptResults.txt
sudo ntfsfix /dev/"$partition" | tee -a /tmp/scriptResults.txt
sudo mount -t ntfs-3g /dev/"$partition" /datadrive | tee -a /tmp/scriptResults.txt

curl -LJ "https://github.com/erocarrera/pefile/releases/download/v2022.5.30/pefile-2022.5.30.zip" -o "/tmp/pefile.zip"
curl -LJ "https://didierstevens.com/files/software/disitool_v0_4.zip" -o "/tmp/disitool.zip"
yum install unzip -y
cd /tmp || return
unzip "/tmp/pefile.zip"
unzip "/tmp/disitool.zip"
cd /tmp/pefile-2022.5.30/ || return
python3 setup.py install
cd /tmp/ || return
cp /datadrive/Windows/System32/drivers/intelide.sys /tmp/intelide-old.sys
python3 disitool.py delete intelide-old.sys intelide.sys
mv /tmp/intelide.sys /datadrive/Windows/System32/drivers/intelide.sys -f
umount /datadrive

cp /datadrive/Windows/System32/drivers/ntfs.sys /tmp/ntfs-old.sys
python3 disitool.py delete ntfs-old.sys ntfs.sys
mv /tmp/ntfs.sys /datadrive/Windows/System32/drivers/ntfs.sys -f



mv /tmp/ntfs-old.sys /datadrive/Windows/System32/drivers/ntfs-old.sys -f
