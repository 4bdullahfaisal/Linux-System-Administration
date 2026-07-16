# Module 3 - File System
---

## What is a File System?

A file system controls how data is stored, organized, and retrieved on a storage device.

**Analogy:** A file system is like a library catalog — it organizes books (files) so they can be easily found.

## Common Linux File System Types

| File System | Use Case |
|-------------|----------|
| **ext4** | Default for most Linux distributions (RHEL, Ubuntu, Oracle Linux) |
| **XFS** | High-performance, large files (default in RHEL) |
| **btrfs** | Advanced features (snapshots, compression) |
| **tmpfs** | Temporary (in memory) |
| **swap** | Virtual memory |

## File System Hierarchy (FHS)

Linux follows the **Filesystem Hierarchy Standard (FHS)** — a standard that defines where things go.

Linux uses a **single root directory** (`/`) with everything organized underneath it.

```bash
ls /
```

| Directory | Purpose |
|-----------|---------|
| `/` | Root directory (top of the tree) |
| `/bin` | Essential user commands (`ls`, `cp`, `mv`, `cat`, `echo`) |
| `/sbin` | System administration commands (`fdisk`, `mount`) |
| `/etc` | Configuration files (system-wide) |
| `/home` | User home directories |
| `/root` | Root user's home directory |
| `/var` | Variable data (logs, caches, spools) |
| `/tmp` | Temporary files (cleared on reboot) |
| `/usr` | User programs and data |
| `/opt` | Optional/third-party software |
| `/dev` | Device files (hardware, disks) |
| `/proc` | Virtual process information (running system) |
| `/sys` | Kernel and hardware info |

## Common Linux File Types

| Symbol | Type | Example |
|--------|------|---------|
| `-` | Regular file | `file.txt`, `script.sh` |
| `d` | Directory | `folder/` |
| `l` | Symbolic link | `link -> target` |
| `c` | Character device | `/dev/tty` (keyboard, serial) |
| `b` | Block device | `/dev/sda` (disk) |
| `s` | Socket | `/run/docker.sock` |
| `p` | Pipe (FIFO) | Inter-process communication |

## Understanding Paths

| Path Type | Example | Description |
|-----------|---------|-------------|
| Absolute | `/home/user/file.txt` | Full path from root `/` |
| Relative | `./file.txt` ``../folder/`` | Path from current directory |

### Special Paths

| Path | Meaning |
|------|---------|
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Home directory |
| `-` | Previous directory (with `cd`) |

---
