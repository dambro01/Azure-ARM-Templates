sudo cp /etc/default/grub /tmp/grub.old

> /etc/default/grub

sudo echo 'GRUB_TIMEOUT=5' >> /etc/default/grub
sudo echo 'GRUB_DISTRIBUTOR="$(sed '\'s, release .*$,,g\'' /etc/system-release)"' >> /etc/default/grub
sudo echo 'GRUB_DEFAULT=saved' >> /etc/default/grub
sudo echo 'GRUB_DISABLE_SUBMENU=true' >> /etc/default/grub
sudo echo 'GRUB_TERMINAL_OUTPUT="console"' >> /etc/default/grub
sudo echo 'GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet"' >> /etc/default/grub
sudo echo 'GRUB_DISABLE_RECOVERY="true"' >> /etc/default/grub

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

sudo sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=static/' /etc/sysconfig/network-scripts/ifcfg-eth0

shutdown -r
