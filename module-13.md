# Module 11 — Logs & Monitoring

---

## Linux Logging System

Linux logs are stored in `/var/log/` directory.

### Common Log Files

| Log File | Purpose |
|----------|---------|
| `/var/log/messages` | General system messages |
| `/var/log/syslog` | System logs (Debian/Ubuntu) |
| `/var/log/auth.log` | Authentication logs |
| `/var/log/secure` | Authentication logs (RHEL-based) |
| `/var/log/maillog` | Mail server logs |
| `/var/log/kern.log` | Kernel logs |
| `/var/log/cron` | Cron job logs |
| `/var/log/boot.log` | Boot process logs |
| `/var/log/dnf.log` | DNF package manager logs |

---

## Viewing Logs

### Basic Commands

```bash
# View entire log
cat /var/log/messages

# View last lines (default 10)
tail /var/log/messages
tail -n 20 /var/log/messages

# Follow log in real-time
tail -f /var/log/messages

# Search for specific text
grep "error" /var/log/messages
grep -i "failed" /var/log/secure

# View with less (scrollable)
less /var/log/messages
```

---

## journalctl (Systemd Logs)

Modern Linux systems use `journalctl` to view logs from systemd journal.

### Basic journalctl Commands

```bash
# View all logs
journalctl

# View logs since boot
journalctl -b

# Follow real-time
journalctl -f

# Show last 10 lines
journalctl -n 10

# Show logs for a specific service
journalctl -u sshd
journalctl -u httpd

# Show logs from last hour
journalctl --since "1 hour ago"

# Show logs by priority (error only)
journalctl -p err

# Show kernel messages
journalctl -k
```

---

## Log Rotation

Logs can fill up disk space. Log rotation automatically archives and deletes old logs.

### logrotate Configuration

Main config file: `/etc/logrotate.conf`

Example for `/var/log/messages`:
```
/var/log/messages {
    weekly
    rotate 4
    compress
    missingok
    notifempty
}
```

### Manual Log Rotation

```bash
# Force rotate logs
sudo logrotate -f /etc/logrotate.conf

# Debug mode (dry run)
sudo logrotate -d /etc/logrotate.conf
```

---

## Monitoring Tools

### System Resource Monitoring

| Tool | Purpose |
|------|---------|
| `top` | Real-time process monitoring |
| `htop` | Enhanced top |
| `free -h` | Memory usage |
| `df -h` | Disk usage |
| `du -sh` | Directory size |
| `uptime` | System load |
| `vmstat` | Virtual memory stats |
| `iostat` | I/O stats |
| `netstat` / `ss` | Network connections |

### Example Commands

```bash
# View system load
uptime

# View memory usage
free -h

# View disk usage
df -h

# View directory size
du -sh /var/log/

# View running processes
top
htop

# View network connections
ss -tulpn
netstat -tulpn
```

---

## Log Monitoring with journalctl

```bash
# Monitor SSH authentication attempts
journalctl -u sshd -f

# Check for failed login attempts
journalctl -u sshd | grep "Failed password"

# Check for sudo usage
journalctl -u sudo

# Monitor system errors
journalctl -p err -f
```

---

## Custom Logging

### Using logger Command

```bash
# Write custom log message
logger "This is a custom log entry"

# With priority
logger -p user.info "Application started"

# Write to syslog
logger -t myapp "Application restarted"
```

### Writing Logs in Scripts

```bash
#!/bin/bash
LOG_FILE="/var/log/myapp.log"
echo "$(date): Application started" >> $LOG_FILE
```

---

## Monitoring System Health

### Check Failed Login Attempts

```bash
# Auth log
grep "Failed password" /var/log/secure
grep "Failed password" /var/log/auth.log

# Count attempts
grep -c "Failed password" /var/log/secure
```

### Check Boot Time

```bash
systemd-analyze
systemd-analyze blame
```

### Check Disk Health

```bash
# Disk space
df -h

# Inode usage
df -i

# Disk I/O
iostat -x 1
```

---

## Log Locations Reference

| Distribution | Log Location |
|--------------|--------------|
| RHEL / Rocky / Alma | `/var/log/messages`, `/var/log/secure` |
| Debian / Ubuntu | `/var/log/syslog`, `/var/log/auth.log` |
| Oracle Linux | `/var/log/messages`, `/var/log/secure` |

---

## Commands Summary
```bash
# Logs
cat /var/log/messages
tail -f /var/log/messages
grep "error" /var/log/messages
journalctl -f
journalctl -u sshd
journalctl -p err

# Monitoring
top
htop
free -h
df -h
du -sh
uptime
ss -tulpn
iostat
vmstat

# Log Rotation
sudo logrotate -f /etc/logrotate.conf
sudo logrotate -d /etc/logrotate.conf

# Custom Logging
logger "Custom message"
logger -t myapp "Application started"
```

---

## Quick Reference

| Task | Command |
|------|---------|
| View system logs | `tail -f /var/log/messages` |
| View service logs | `journalctl -u service-name` |
| Follow real-time | `journalctl -f` |
| Check disk space | `df -h` |
| Check memory | `free -h` |
| Check running processes | `top` |
| Check failed logins | `grep "Failed password" /var/log/secure` |

---
