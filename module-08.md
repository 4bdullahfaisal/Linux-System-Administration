# Module 8 — Package management (Repositories, Package Management)
**Environment:** Oracle Linux 9 on VirtualBox
---

## Configuring Repositories

A repository is a storage location from which the system downloads and installs software packages.

### Repository Files Location

`/etc/yum.repos.d/`

View existing repo files:

`ls -la /etc/yum.repos.d/`

### View Repositories

`dnf repolist`           — List enabled repos

`dnf repolist all`       — List all repos (enabled + disabled)

### .repo File Structure

```bash
[repo-name]
name=Description of Repository
baseurl=http://example.com/path/to/repo
enabled=1
gpgcheck=1
gpgkey=http://example.com/path/to/gpg-key
```

### Basic Repo Commands

```bash
sudo dnf config-manager --set-enabled repo-name   # Enable repo

sudo dnf config-manager --set-disabled repo-name  # Disable repo
```

---

## Package Management (yum/dnf)

Basic commands for installing, updating, and removing software.

### Important Note

On modern RHEL-based systems (Oracle Linux 9, Rocky 9, Alma 9), `dnf` is the default. `yum` works as a symlink to `dnf`.

### Basic Commands

```bash
yum search package           # Search for a package

yum info package             # Get package details

sudo yum install package -y  # Install a package

sudo yum update package      # Update a specific package
```

### Group Packages

`yum group list`               — List available package groups
`sudo yum group install "group name" -y`   — Install a group

### Practice Example

```bash
sudo yum install httpd -y

yum list installed | grep httpd

sudo yum remove httpd -y
```

---

## Commands Summary

```bash
### Repositories
dnf repolist
ls /etc/yum.repos.d/

### Package Management
yum search <package>
sudo yum install <package>
sudo yum update <package>
sudo yum remove <package>
yum list installed

sudo systemctl stop <service>
sudo systemctl enable <service>
sudo systemctl disable <service>
systemctl is-enabled <service>
systemctl list-units --type=service
```
---
