# Task 1 — Secure Multi-User Application Server

**Environment:** Oracle Linux 9 on VirtualBox  
**Web Server:** Apache (httpd)

---

## Set up system
```bash
# Set hostname
sudo hostnamectl set-hostname appserver

# Install Apache (httpd)
sudo dnf install httpd -y

# Install essential tools
sudo dnf install -y vim wget curl git
```
## Create users and groups

```bash
# Create groups
sudo groupadd developers
sudo groupadd devops

# Create users
sudo useradd dev1
sudo useradd dev2
sudo useradd ops1

# Add users to groups
sudo usermod -aG developers dev1
sudo usermod -aG developers dev2
sudo usermod -aG devops ops1
```

## Configure access

```bash
# Give ops1 full sudo access
sudo visudo -f /etc/sudoers.d/ops1

# Add line:
ops1 ALL=(ALL) ALL
```

## Deploy a simple web app (Apache)

```bash
# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Create web app directory
sudo mkdir -p /var/www/app

# Create a sample index.html
echo "<h1>Welcome to Dev Team App</h1>" | sudo tee /var/www/app/index.html
```

```bash

# Configure Apache to serve from /var/www/app
sudo nano /etc/httpd/conf.d/app.conf

# Add:
<VirtualHost *:80>
    DocumentRoot /var/www/app
    <Directory /var/www/app>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>

# Restart Apache
sudo systemctl restart httpd

```

## Secure /var/www/app so only developers can modify
```bash
# Change group ownership to developers
sudo chown -R root:developers /var/www/app

# Set permissions: developers can write, others read only
sudo chmod -R 775 /var/www/app

# Verify
ls -ld /var/www/app
```

## Disable root SSH login
```bash
sudo nano /etc/ssh/sshd_config

# Find & change to:
PermitRootLogin no             # Change
PasswordAuthentication yes     # Change

# Restart SSH
sudo systemctl restart sshd    # Restart Apache
```

## Open only required ports (SSH and HTTP)

```bash
# Allow SSH and HTTP
sudo firewall-cmd --add-service=ssh --permanent
sudo firewall-cmd --add-service=http --permanent

# Reload firewall
sudo firewall-cmd --reload

# Verify
sudo firewall-cmd --list-all
```

## Create custom background service with auto-restart

```bash
sudo nano /etc/systemd/system/app.service
```

```bash
[Unit]
Description=Custom App Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/var/www/app
ExecStart=/usr/bin/python3 -m http.server 8080
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```
```bash
# Start and enable service
sudo systemctl start app
sudo systemctl enable app

# Verify
sudo systemctl status app
```
## Create deployment script

```bash
sudo nano /usr/local/bin/deploy.sh
```

```bash
#!/bin/bash
LOG="/var/log/deploy.log"
echo "$(date) - Deployment started" >> $LOG

cd /var/www/app

# Pull latest code (example)
echo "$(date) - Updating application" >> $LOG
echo "<h1>Updated at $(date)</h1>" > index.html

# Restart service
sudo systemctl restart app
echo "$(date) - Service restarted" >> $LOG
echo "$(date) - Deployment completed" >> $LOG
```
```bash
# Make executable
sudo chmod +x /usr/local/bin/deploy.sh

# Test script
sudo /usr/local/bin/deploy.sh
```

## Test deployment script

```bash
sudo /usr/local/bin/deploy.sh
```

## Verification commands
```bash
# Test Apache
curl localhost

# Test custom service
curl localhost:8080

# Check firewall
sudo firewall-cmd --list-all

# Should show active (running)
sudo systemctl status app      
```
