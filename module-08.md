# Module 8 — Package management (Repositories, Package Management)
**Environment:** Oracle Linux 9 on VirtualBox
---

## Configuring Repositories

A repository is a storage location from which the system downloads and installs software packages.

### Repository Files Location

`/etc/yum.repos.d/`

View existing repo files:

`ls -la /etc/yum.repos.d/`

### .repo File Structure

```bash
[repo-name]
name=Description of Repository
baseurl=http://example.com/path/to/repo
enabled=1
gpgcheck=1
gpgkey=http://example.com/path/to/gpg-key
```

### Repository Management (dnf/yum)

| Task | Command |
|------|---------|
| List enabled repos | `dnf repolist` |
| List all repos | `dnf repolist all` |
| Enable a repo | `sudo dnf config-manager --set-enabled epel` |
| Disable a repo | `sudo dnf config-manager --set-disabled epel` |

---

## What is a Package Manager?

A package manager is a tool that automates the installation, upgrade, configuration, and removal of software on a Linux system.

**Analogy:** Package managers are like app stores for Linux.

### Important Note

On modern RHEL-based systems (Oracle Linux 9, Rocky 9, Alma 9), `dnf` is the default. `yum` works as a symlink to `dnf`.

---

## Two Main Families

| Family | Distros | Package Manager | Package Format |
|--------|---------|----------------|-----------------|
| Debian | Ubuntu, Debian, Linux Mint | `apt` | `.deb` |
| Red Hat | RHEL, CentOS, Rocky, Oracle, Fedora | `yum` / `dnf` | `.rpm` |

### Common Commands (dnf/yum)

| Task | Command |
|------|---------|
| Search for a package | `dnf search nginx` |
| Get package info | `dnf info nginx` |
| Install a package | `sudo dnf install nginx -y` |
| Remove a package | `sudo dnf remove nginx -y` |
| Update a package | `sudo dnf update nginx` |
| Update all packages | `sudo dnf update -y` |
| List installed packages | `dnf list installed` |
| List available packages | `dnf list available` |
| Check for updates | `dnf check-update` |
| Find which package provides a file | `dnf provides /etc/nginx/nginx.conf` |
| Show package dependencies | `dnf deplist nginx` |
| Download without installing | `dnf download nginx` |

## Common Package Names to Know

| Purpose | Package | Command |
|---------|---------|---------|
| Web server | httpd, nginx | `sudo dnf install httpd` |
| Database | mariadb-server, postgresql-server | `sudo dnf install mariadb-server` |
| Text editor | vim, nano | `sudo dnf install vim` |
| Networking tools | net-tools, traceroute | `sudo dnf install net-tools` |
| Compression | tar, gzip, zip | `sudo dnf install tar` |
| Git | git | `sudo dnf install git` |
| Docker | docker-ce | (requires adding repo) |


### Group Management (dnf/yum)

Groups allow you to install related packages together.

```bash
# List all package groups
yum group list

# List available groups
yum group list | grep -i "development"

# Install a group
sudo yum group install "Development Tools" -y

# Remove a group
sudo yum group remove "Development Tools" -y

# Install group (RHEL 8)
sudo dnf group install "Development Tools" -y
```

### Common Groups:

| Group Name | What it installs |
|------------|------------------|
| Development Tools | gcc, make, git, etc. |
| Web Server | httpd, php, etc. |
| Database Server | mysql, postgres, etc. |
| Security Tools | firewalld, selinux, etc. |

---

### Cache Management (dnf/yum)

| Task | Command |
|------|---------|
| Clean all cache | `sudo dnf clean all` |
| Rebuild cache | `sudo dnf makecache` |

## Command-Specific Common Flags

| Flag | What it does | Example |
|------|--------------|---------|
| `-y` | Auto yes | `sudo dnf install nginx -y` |
| `-f` | Fix broken | `sudo apt install -f` |
| `-q` | Quiet | `dnf install nginx -q` |
| `-v` | Verbose | `dnf install nginx -v` |
| `--help` | Show help | `dnf --help` |
| `--version` | Show version | `dnf --version` |
| `--nogpgcheck` | Skip GPG check | `dnf install --nogpgcheck package.rpm` |


## Common Scenario Examples

### Scenario 1: Setting Up a Web Server

```bash
# Install Apache
sudo dnf install httpd -y

# Start and enable service
sudo systemctl start httpd
sudo systemctl enable httpd

# Install PHP
sudo dnf install php php-mysqlnd -y

# Install MariaDB
sudo dnf install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
```
