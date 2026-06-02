# Linux Commands

### File Operations
```
pwd                         # Show current directory
ls                          # List files
ls -la                      # List all files (including hidden)
cd <folder>                 # Change directory
cd ~                        # Go to home directory
mkdir <name>                # Create directory
touch <file>                # Create empty file
cat <file>                  # View file content
cat > <file>                # Create file (type content, Ctrl+D to save)
cat >> <file>               # Append to existing file
nano <file>                 # Edit file with nano editor
rm <file>                   # Remove file
rm -rf <folder>             # Remove folder recursively
cp <source> <dest>          # Copy file
mv <source> <dest>          # Move/rename file
```
### Viewing File Parts

- `head <file>`             - Show first 10 lines
- `head -n 20 <file>`       - Show first 20 lines
- `tail <file>`             - Show last 10 lines  
- `tail -n 15 <file>`       - Show last 15 lines
- `tail -f <file>`          - Follow file (watch new lines in real-time)
- `head -20 file | tail -10`- Show lines 11-20 (middle section)

### File Content
```
echo "text"                 # Print text
echo "text" > file.txt      # Write text to file (overwrite)
echo "text" >> file.txt     # Append text to file
head <file>                 # Show first 10 lines
tail <file>                 # Show last 10 lines
grep "pattern" <file>       # Search text in file
| (pipe)                    # Send output of one command as input to another
```

### Terminal Shortcuts
`Ctrl+C` - Cancel/terminate current command  
`Ctrl+D` - Exit shell or end file input  
`Ctrl+Z` - Suspend current process  
`Ctrl+R` - Search command history  
`Ctrl+L` or `clear` - Clear terminal screen  
`!!` - Repeat last command  
`!$` - Last argument of previous command  

