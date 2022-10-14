# Sets bad permissions on the SSH host key file
sudo chmod -R 777 /etc/ssh
sudo chmod 777 /etc/ssh/ssh_host*key
sudo chmod 777 /etc/ssh/ssh_host*key.pub
sudo chmod 777 /etc/ssh/sshd_config
shutdown -r
