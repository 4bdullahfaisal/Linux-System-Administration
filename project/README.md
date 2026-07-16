# Log Monitor 

## Overview
A simple Bash script that monitors a log file in real-time and alerts when "ERROR" appears in the logs.

## Project Structure
```
~/devops-learning/
├── logs/
│   └── app.log
└── monitor.sh
```

## Implementation Steps

### Step 1: Create Log Directory and Initial Log File

```bash
# Create log directory
mkdir -p ~/devops-learning/logs

# Create initial log file
echo "INFO: Server started" > ~/devops-learning/logs/app.log
echo "INFO: User logged in" >> ~/devops-learning/logs/app.log
```

> **Note:** `>` overwrites the file, `>>` appends to the file.

### Step 2: Create the Monitoring Script

Create `~/devops-learning/monitor.sh` with the following content:

```bash
#!/bin/bash

LOG_FILE="$HOME/devops-learning/logs/app.log"

echo "Monitoring $LOG_FILE for errors..."
echo "Press Ctrl+C to stop"

tail -f "$LOG_FILE" | while read line; do
    if echo "$line" | grep -q "ERROR"; then
        echo "⚠️ ALERT: Error detected at $(date)"
        echo "Log line: $line"
    fi
done
```

### Step 3: Make Script Executable

```bash
chmod +x ~/devops-learning/monitor.sh
```

### Step 4: Run the Monitor

```bash
./monitor.sh
```

## Testing

In a separate terminal, add an error line to the log file:

```bash
echo "ERROR: Database connection failed" >> ~/devops-learning/logs/app.log
```

The monitor script should display an alert in the original terminal.

## Key Features

- **Real-time monitoring** using `tail -f`
- **Error detection** via `grep` pattern matching
- **Timestamped alerts** showing when errors occur
- **Continuous monitoring** until manually stopped (Ctrl+C)

## Usage

1. Start the monitor: `./monitor.sh`
2. The script will display a banner and wait for new log entries
3. Any line containing "ERROR" will trigger an alert
4. Press `Ctrl+C` to stop monitoring

## Technical Notes

- The script uses a pipeline to process each new line as it's added
- `grep -q` suppresses output and returns an exit status
- The `while read` loop processes lines one by one
- `$(date)` provides a timestamp for each alert

## Learning Outcomes

- Basic Bash scripting
- File operations (`>` vs `>>`)
- Real-time log monitoring with `tail -f`
- Pattern matching with `grep`
- Command pipelines and redirection
- Making scripts executable with `chmod`
