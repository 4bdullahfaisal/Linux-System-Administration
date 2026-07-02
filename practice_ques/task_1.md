# Task 1 — Secure Multi-User Application Server

**Environment:** Oracle Linux 9 on VirtualBox  
**Web Server:** Apache (httpd)

---

## Set hostname and update system

sudo hostnamectl set-hostname appserver
sudo dnf update -y

## Install Apache (httpd)

sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

## Create groups

sudo groupadd developers

sudo groupadd devops

## Create users

sudo useradd dev1

sudo useradd dev2

sudo useradd ops1

## Add users to groups

sudo usermod -aG developers dev1

sudo usermod -aG developers dev2

sudo usermod -aG devops ops1

## Give ops1 full sudo access

sudo visudo -f /etc/sudoers.d/ops1

- Add line: `ops1 ALL=(ALL) ALL`

## Create web directory and sample app

sudo mkdir -p /var/www/app

echo "<h1>Welcome to Dev Team App</h1>" | sudo tee /var/www/app/index.html

## Configure Apache to serve from /var/www/app

sudo nano /etc/httpd/conf.d/app.conf
```
# Add:
# <VirtualHost *:80>
#     DocumentRoot /var/www/app
#     <Directory /var/www/app>
#         Options Indexes FollowSymLinks
#         AllowOverride None
#         Require all granted
#     </Directory>
# </VirtualHost>
```
sudo systemctl restart httpd

## Secure directory (only developers can modify)

sudo chown -R root:developers /var/www/app

sudo chmod -R 775 /var/www/app

## Disable root SSH login

sudo nano /etc/ssh/sshd_config
```
# Change: PermitRootLogin no
# Change: PasswordAuthentication yes
```

sudo systemctl restart sshd

## Open only required ports (SSH and HTTP)

sudo firewall-cmd --add-service=ssh --permanent

sudo firewall-cmd --add-service=http --permanent

sudo firewall-cmd --reload

## Create custom background service with auto-restart

sudo nano /etc/systemd/system/app.service
```
# Add:
# [Unit]
# Description=Custom App Service
# After=network.target
#
# [Service]
# Type=simple
# User=root
# WorkingDirectory=/var/www/app
# ExecStart=/usr/bin/python3 -m http.server 8080
# Restart=always
# RestartSec=10
#
# [Install]
# WantedBy=multi-user.target
```
sudo systemctl start app
sudo systemctl enable app

## Create deployment script

sudo nano /usr/local/bin/deploy.sh
```
# Add:
# #!/bin/bash
# LOG="/var/log/deploy.log"
# DATE=$(date '+%Y-%m-%d %H:%M:%S')
#
# echo "$DATE - Deployment started" >> $LOG
# cd /var/www/app
# echo "<h1>App Updated at $DATE</h1>" | sudo tee index.html
# sudo systemctl restart app
# echo "$DATE - Service restarted" >> $LOG
# echo "$DATE - Deployment completed" >> $LOG
```
sudo chmod +x /usr/local/bin/deploy.sh

## Test deployment script

sudo /usr/local/bin/deploy.sh

## Verification commands
```
curl localhost                 # Should show updated app
curl localhost:8080            # Should show same content
sudo systemctl status app      # Should show active (running)
sudo firewall-cmd --list-all   # Should show ssh, http
sudo cat /var/log/deploy.log   # Should show deployment logs
```
