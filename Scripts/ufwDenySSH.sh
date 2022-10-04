# Enable ufw and block SSH
sudo ufw --force enable
sudo ufw deny ssh
sudo ufw reload