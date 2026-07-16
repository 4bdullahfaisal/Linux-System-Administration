#!/bin/bash

LOG_FILE="$HOME/Documents/linux-project/logs/app.log"

echo "Monitoring $LOG_FILE for errors..."
echo "Press Ctrl+C to stop"

tail -f "$LOG_FILE" | while read line; do
    if echo "$line" | grep -q "ERROR"; then
        echo "⚠️ ALERT: Error detected at $(date)"
        echo "Log line: $line"
    fi
done
