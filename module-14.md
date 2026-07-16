# Module 14 — Archiving & Backup
---

## Archiving vs Compression

| Concept | What it does | Tool |
|---------|--------------|------|
| **Archiving** | Combines multiple files into one | `tar` |
| **Compression** | Reduces file size | `gzip`, `bzip2`, `xz` |
| **Both** | Archive + compress together | `tar` with options |

**Analogy:**  
- Archive = packing clothes in a suitcase  
- Compression = vacuum-sealing the suitcase

---

## tar (Tape Archive)

`tar` is the most common archiving tool in Linux.

### tar Options

| Option | Meaning |
|--------|---------|
| `-c` | Create archive |
| `-x` | Extract archive |
| `-t` | View contents |
| `-v` | Verbose (show files) |
| `-f` | File name |
| `-z` | Compress with gzip |
| `-j` | Compress with bzip2 |
| `-J` | Compress with xz |

### Create Archive

```bash
# Create uncompressed tar file
tar -cvf archive.tar /path/to/folder

# Create gzip compressed archive (.tar.gz)
tar -czvf archive.tar.gz /path/to/folder

# Create bzip2 compressed archive (.tar.bz2)
tar -cjvf archive.tar.bz2 /path/to/folder

# Create xz compressed archive (.tar.xz)
tar -cJvf archive.tar.xz /path/to/folder
```

### Extract Archive

```bash
# Extract tar
tar -xvf archive.tar

# Extract tar.gz
tar -xzvf archive.tar.gz

# Extract tar.bz2
tar -xjvf archive.tar.bz2

# Extract tar.xz
tar -xJvf archive.tar.xz

# Extract to specific directory
tar -xzvf archive.tar.gz -C /target/directory
```

### View Archive Contents

```bash
# List contents without extracting
tar -tvf archive.tar
tar -tzvf archive.tar.gz
```

### Exclude Files/Directories

```bash
tar -czvf backup.tar.gz /home/user --exclude=/home/user/Downloads
tar -czvf backup.tar.gz /home/user --exclude=*.mp4
```

---

## Compression Tools

| Tool | Extension | Speed | Compression Ratio |
|------|-----------|-------|-------------------|
| `gzip` | `.gz` | Fast | Medium |
| `bzip2` | `.bz2` | Slow | High |
| `xz` | `.xz` | Slowest | Highest |
| `zip` | `.zip` | Fast | Medium |

### gzip

```bash
# Compress file
gzip file.txt          # Creates file.txt.gz

# Decompress
gunzip file.txt.gz

# Keep original file
gzip -k file.txt
```

### bzip2

```bash
# Compress
bzip2 file.txt         # Creates file.txt.bz2

# Decompress
bunzip2 file.txt.bz2
```

### xz

```bash
# Compress
xz file.txt            # Creates file.txt.xz

# Decompress
unxz file.txt.xz
```

### zip / unzip

```bash
# Create zip
zip archive.zip file1.txt file2.txt
zip -r archive.zip /path/to/folder

# Extract zip
unzip archive.zip

# List contents
unzip -l archive.zip
```

---

## Backup Strategies

### Simple Backup Script

```bash
#!/bin/bash
# backup.sh

SOURCE="/home/user/data"
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_$DATE.tar.gz"

mkdir -p $BACKUP_DIR
tar -czvf $BACKUP_DIR/$BACKUP_FILE $SOURCE
echo "Backup created: $BACKUP_FILE"
```

### Incremental Backup with tar

```bash
# Full backup
tar -czvf full_backup.tar.gz /home/user

# Incremental backup (only changed files)
tar -czvf inc_backup.tar.gz -g snapshot.snar /home/user
```

### Backup with Rotation (Keep last 7 days)

```bash
#!/bin/bash
BACKUP_DIR="/backup"
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
```

---

## Remote Backup (scp / rsync)

### Using scp

```bash
# Copy backup to remote server
scp backup.tar.gz user@192.168.1.100:/backup/
```

### Using rsync (Recommended)

```bash
# Sync local folder to remote
rsync -avz /local/data/ user@192.168.1.100:/remote/backup/

# Sync with delete (mirror exact)
rsync -avz --delete /local/data/ user@192.168.1.100:/remote/backup/

# Keep backup on remote
rsync -avz /local/data/ /mnt/backup/
```

---

## Backup with Compression

```bash
# Backup and compress in one command
tar -czvf /backup/backup_$(date +%Y%m%d).tar.gz /home/user/data

# Backup large directories with progress
tar -czvf backup.tar.gz /home/user 2>&1 | while read line; do echo -n "."; done
```

---

## Archiving & Backup Commands Summary

| Task | Command |
|------|---------|
| Create tar.gz | `tar -czvf archive.tar.gz /path` |
| Extract tar.gz | `tar -xzvf archive.tar.gz` |
| Create tar.bz2 | `tar -cjvf archive.tar.bz2 /path` |
| Extract tar.bz2 | `tar -xjvf archive.tar.bz2` |
| View archive | `tar -tvf archive.tar` |
| Compress file | `gzip file` / `bzip2 file` / `xz file` |
| Create zip | `zip -r archive.zip /path` |
| Extract zip | `unzip archive.zip` |
| Remote copy | `scp file user@host:/path` |
| Sync backup | `rsync -avz /source/ /destination/` |
| Delete old backups | `find /backup -name "*.tar.gz" -mtime +7 -delete` |

---
