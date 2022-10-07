# Enables SELinux in Enforcing mode and deletes contents of policies folder
sudo setenforce 1
rm -r -f /etc/selinux/targeted/policy/
sudo reboot