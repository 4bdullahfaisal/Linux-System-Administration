# Module 4 — File Permissions 
---
## Permission Types

| Number | Permission | File Meaning | Directory Meaning |
|--------|------------|--------------|-------------------|
| 4 | `r` (read) | View file content | List files inside |
| 2 | `w` (write) | Modify file content | Create/delete files inside |
| 0 | `x` (execute) | Run as a program/script | Enter the directory |

---

## Owner & Group

| Owner | Meaning |
|-------|---------|
| **User (u)** | File owner |
| **Group (g)** | Group owner |
| **Others (o)** | Everyone else |

---

## View Permissions

```bash
ls -l
```

Example output:
```
-rwxr-xr-- 1 user group 1024 Apr 1 10:00 file.txt
```

### Breakdown:

| Part | Meaning |
|------|---------|
| `-` | File type (`-` = file, `d` = directory, `l` = link) |
| `rwx` | User permissions |
| `r-x` | Group permissions |
| `r--` | Others permissions |
| `user` | Owner name |
| `group` | Group name |

---

## Changing Permissions (chmod)

### Symbolic Mode

```bash
# Add execute permission for user
chmod u+x file.sh

# Remove write permission for group
chmod g-w file.sh

# Give read permission to others
chmod o+r file.sh

# Add read and execute for group
chmod g+rx file.sh

# Combine multiple
chmod u+rwx,g+rx,o+r file.sh
```

### Numeric Mode (Octal)

| Number | Permission |
|--------|------------|
| 7 | rwx (4+2+1) |
| 6 | rw- (4+2) |
| 5 | r-x (4+1) |
| 4 | r-- |
| 3 | -wx (2+1) |
| 2 | -w- |
| 1 | --x |
| 0 | --- |

```bash
# User: rwx, Group: r-x, Others: r--
chmod 754 file.sh

# User: rw-, Group: r--, Others: ---
chmod 640 file.txt

# Everyone: rwx
chmod 777 file.sh  # Not recommended
```

---

## Common Permission Examples

| Permission | Numeric | Use Case |
|------------|---------|----------|
| `-rw-------` | 600 | Private file (only owner) |
| `-rw-r-----` | 640 | Owner + group read |
| `-rw-r--r--` | 644 | Public read, private write |
| `-rwx------` | 700 | Private script |
| `-rwxr-xr-x` | 755 | Public script |
| `-rwxrwxrwx` | 777 | Public (insecure, avoid) |

---

## Changing Ownership (chown)

```bash
# Change user owner
sudo chown user file.txt

# Change group owner
sudo chgrp group file.txt

# Change both user and group
sudo chown user:group file.txt

# Change ownership of directory (recursive)
sudo chown -R user:group /path/to/dir
```

---

## Directory Permissions

| Permission | Effect on Directory |
|------------|---------------------|
| `r` | Can list contents (`ls`) |
| `w` | Can create/delete files (`touch`, `rm`) |
| `x` | Can enter directory (`cd`) |

### Example

```bash
# Create directory with full access
mkdir testdir
chmod 755 testdir

# Only owner can enter
chmod 700 private_dir

# Everyone can list and enter
chmod 755 shared_dir
```
---

## umask — Default Permissions

umask = default permissions when creating files/directories.

Formula:
- File: `666 - umask`
- Directory: `777 - umask`

```bash
# View current umask
umask

# Set umask (e.g., 022)
umask 022

# With 022:
# Files = 666 - 022 = 644 (rw-r--r--)
# Directories = 777 - 022 = 755 (rwxr-xr-x)
```
---

### Common umask Values

| umask | File Permissions | Directory Permissions |
|-------|------------------|----------------------|
| 022 | 644 (rw-r--r--) | 755 (rwxr-xr-x) |
| 002 | 664 (rw-rw-r--) | 775 (rwxrwxr-x) |
| 027 | 640 (rw-r-----) | 750 (rwxr-x---) |
| 077 | 600 (rw-------) | 700 (rwx------) |

---

## Practice Exercises

```bash
# Create a file
touch test.txt

# Give owner read+write, group read, others none
chmod 640 test.txt

# Verify
ls -l test.txt

# Make it executable
chmod +x test.txt

# Change owner to root (requires sudo)
sudo chown root test.txt

# Create a directory and give full access to owner only
mkdir private
chmod 700 private
ls -ld private
```

---

## Commands Summary

```bash
ls -l                       # View permissions
chmod u+x file              # Add execute for user
chmod 755 file              # Set permissions numerically i.e rwxr-xr-x
chown user file             # Change user owner
chgrp group file            # Change group owner
chown user:group file       # Change both
chmod -R 755 dir            # Apply recursively
```

---

## Quick Reference

| Command | Effect |
|---------|--------|
| `chmod u+rwx file` | User = rwx |
| `chmod g+rx file` | Group = r-x |
| `chmod o+r file` | Others = r-- |
| `chmod 755 file` | rwxr-xr-x |
| `chmod 644 file` | rw-r--r-- |
| `chmod 600 file` | rw------- |
| `chown user file` | Change owner to user |
| `chgrp group file` | Change group to group |

---
