# Sets bad permissions on the SSH host key file
sudo chmod -R 777 /etc/ssh
sudo chmod 777 /etc/ssh/ssh_host*key
sudo chmod 777 /etc/ssh/ssh_host*key.pub
sudo chmod 777 /etc/ssh/sshd_config
shutdown -r



chmod -R 600 /etc/ssh
chmod 700 /etc/ssh/ssh_host*key
chmod 644 /etc/ssh/ssh_host*key.pub
chmod 640 /etc/ssh/sshd_config
chmod 755 /var/lib/empty



https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495366/Server-Unexpectedly-Closed-the-Network-Connection_RDP-SSH