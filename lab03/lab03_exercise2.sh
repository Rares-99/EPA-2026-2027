#!/bin/bash

# Check that exactly one non-negative whole number was supplied
if [ "$#" -ne 1 ] || ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Usage: $0 NON_NEGATIVE_INTEGER"
    exit 1
fi

# Count processes without the header row

ct=$(ps -e --no-headers | wc -l)

# Check whether the process count exceeds the supplied limit
# Append the result with a timestamp to the log file
if [ "$ct" -gt "$1" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Maximum number of processes exceeded" >> process_log.txt
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') The maximum number of processes NOT exceeded" >> process_log.txt
fi
