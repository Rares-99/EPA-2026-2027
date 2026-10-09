#!/bin/bash

# Display instructions for running this script
usage() {
    echo "Usage: $0 MIN_NUM_CORES"
}

# Require one positive whole number as the minimum CPU count
if [ "$#" -ne 1 ] || ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
    usage
    exit 1
fi

# Find processor entries and count them
num_cpu=$(grep '^processor' /proc/cpuinfo | wc -l)

# Stop if the VM has fewer CPUs than required
if [ "$num_cpu" -lt "$1" ]; then
    echo "Error: $1 CPUs required, but only $num_cpu available."
    exit 1
fi

echo "OK: $num_cpu CPUs available; minimum required is $1."
