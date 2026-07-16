# Module 9 — System Management 
---

## System Services (systemctl)

systemctl manages systemd services — programs that run in the background.

### Service States

| State | Meaning |
|-------|---------|
| active (running) | Service is running |
| inactive (dead) | Service is stopped |
| enabled | Starts on boot |
| disabled | Does not start on boot |
| masked | Cannot be started (locked) |

### Basic systemctl Commands

```bash
systemctl status service              # Check service status
sudo systemctl start service          # Start a service
sudo systemctl stop service           # Stop a service
sudo systemctl restart service        # Restart a service
sudo systemctl reload service         # Reload config without restart
sudo systemctl enable service         # Enable on boot
sudo systemctl disable service        # Disable on boot
systemctl is-enabled service          # Check if enabled
systemctl list-units --type=service           # List all active services
systemctl list-unit-files --type=service      # List all services with status
```

### Service Management Practice

```bash
# Check SSH service
systemctl status sshd

# Start Apache if installed
sudo systemctl start httpd
sudo systemctl enable httpd
systemctl is-enabled httpd
```

---
