#!/bin/bash

# Require a process limit and an output mode
if [ "$#" -ne 2 ] || ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Usage: $0 NON_NEGATIVE_INTEGER screen|file"
    exit 1
fi

# Check that the chosen output mode is valid
mode="$2"
if [ "$mode" != "screen" ] && [ "$mode" != "file" ]; then
    echo "Output mode must be screen or file"
    exit 1
fi

# Count processes without the header row

ct=$(ps -e --no-headers | wc -l)

# Check whether the process count exceeds the supplied limit
# Choose the message based on the process count
if [ "$ct" -gt "$1" ]; then
    message="Maximum number of processes exceeded"
else
    message="The maximum number of processes NOT exceeded"
fi

# Send the result to the selected destination
if [ "$mode" = "screen" ]; then
    echo "$message"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') $message" >> process_log.txt
fi
