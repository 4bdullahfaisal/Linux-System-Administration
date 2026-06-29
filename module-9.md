# Module 9 — Network Management (Networking, Firewalld & AutoFS)
**Environment:** Oracle Linux 9 on VirtualBox

---

## Basic Networking Commands

### Check IP Address

`ip a`

`ip addr show`

### Check Hostname

`hostname`                 — Short hostname

`hostnamectl`              — Full system info

### Change Hostname (Permanent)

`sudo hostnamectl set-hostname myserver`

### Test Connectivity

`ping -c 4 8.8.8.8`

`ping -c 4 google.com`

### Show Routing Table

`ip route`

### Show Network Interfaces

`ip link`

### Network Configuration Files

`/etc/hostname`            — Permanent hostname

`/etc/hosts`               — Local DNS resolution

`/etc/resolv.conf`         — DNS servers

---

## Managing Network Connections with nmcli

`nmcli` is the command-line tool for NetworkManager.

### Check NetworkManager Status

`systemctl status NetworkManager`

### List Connections

`nmcli connection show`

`nmcli con show`

### Show Active Connections Only

`nmcli con show --active`

### Show Device Status

`nmcli device status`

### Show Connection Details

`nmcli con show "enp0s3"`

### Show IP via nmcli

`nmcli device show enp0s3 | grep IP4`

### Add a Static Connection (Example)

`sudo nmcli con add con-name static-eth0 ifname enp0s3 type ethernet ip4 192.168.100.10/24 gw4 192.168.100.1`

### Modify to DHCP

`sudo nmcli con mod "enp0s3" ipv4.method auto`

### Activate/Deactivate Connection

`sudo nmcli con up "enp0s3"`

`sudo nmcli con down "enp0s3"`

### Delete Connection

`sudo nmcli con delete static-eth0`

### Restart NetworkManager

`sudo systemctl restart NetworkManager`

---

## Firewall Configuration with firewalld

firewalld is the dynamic firewall manager using zones and services.

### Check Firewalld Status

`sudo systemctl status firewalld`

### Start and Enable Firewalld

`sudo systemctl start firewalld`

`sudo systemctl enable firewalld`

### Check Default Zone

`sudo firewall-cmd --get-default-zone`

### List All Available Zones

`sudo firewall-cmd --get-zones`

### List Services Allowed in Default Zone

`sudo firewall-cmd --list-services`

### List All Rules

`sudo firewall-cmd --list-all`

### Add a Service (e.g., HTTP)

`sudo firewall-cmd --add-service=http --permanent`

`sudo firewall-cmd --reload`

### Add a Port

`sudo firewall-cmd --add-port=8080/tcp --permanent`

`sudo firewall-cmd --reload`

### Remove a Service

`sudo firewall-cmd --remove-service=http --permanent`

`sudo firewall-cmd --reload`

### Check if Service is Allowed

`sudo firewall-cmd --query-service=http`

### Change Default Zone

`sudo firewall-cmd --set-default-zone=internal`

### Block/Allow Ping

`sudo firewall-cmd --add-icmp-block=echo-request --permanent`

`sudo firewall-cmd --remove-icmp-block=echo-request --permanent`

`sudo firewall-cmd --reload`

### Rich Rule (Allow Specific IP)

`sudo firewall-cmd --add-rich-rule='rule family="ipv4" source address="192.168.1.100" accept' --permanent`

`sudo firewall-cmd --reload`

### Reload Firewalld

`sudo firewall-cmd --reload`

---

## AutoFS — Automount NFS Shares On-Demand

AutoFS mounts NFS shares when accessed and unmounts after idle time.

### Install AutoFS

`sudo dnf install autofs -y`

### Install NFS Utilities (for NFS server)

`sudo dnf install nfs-utils -y`

### Create a Local NFS Share for Practice

`sudo mkdir -p /srv/nfs-share`

`echo "AutoFS test file" | sudo tee /srv/nfs-share/test.txt`

### Start NFS Server

`sudo systemctl enable --now nfs-server`

### Export the Share

`echo "/srv/nfs-share *(rw,sync,no_subtree_check)" | sudo tee /etc/exports`

`sudo exportfs -a`

### Configure AutoFS Master File

`sudo nano /etc/auto.master`

Add line: `/auto /etc/auto.nfs`

### Create AutoFS Map File

`sudo nano /etc/auto.nfs`

Add line: `nfs-share -fstype=nfs4,rw localhost:/srv/nfs-share`

### Start and Enable AutoFS

`sudo systemctl enable --now autofs`

### Test AutoFS

`ls /auto/nfs-share`

`cat /auto/nfs-share/test.txt`

### Check Mount

`df -h | grep nfs`

`mount | grep nfs`

### Stop AutoFS

`sudo systemctl stop autofs`

---

## Commands Summary

### Networking

```
ip a                                       # Show IPs
hostnamectl                                # System hostname info
sudo hostnamectl set-hostname name         # Set permanent hostname
ping -c 4 host                             # Test connectivity
ip route                                   # Routing table

### nmcli
nmcli con show                             # List connections
nmcli device status                        # Device status
nmcli con show "name"                      # Connection details
sudo nmcli con up/down "name"              # Activate/deactivate

### firewalld
sudo systemctl status firewalld
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --list-all
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload

### AutoFS
sudo dnf install autofs -y
sudo systemctl enable --now autofs
# Edit /etc/auto.master and /etc/auto.nfs
ls /auto/mountpoint
```
