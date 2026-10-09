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

# Ask which software needs the CPU check
read -r -p "Software name: " software_name

# Stop if input cannot be read or the name is empty
if [ -z "$software_name" ]; then
    printf 'Error: enter a software name.\n'
    exit 1
fi

# Find processor entries and count them
num_cpu=$(grep '^processor' /proc/cpuinfo | wc -l)

# Display a formatted requirements report
printf '\nSoftware: %s\nAvailable CPUs: %s\nRequired CPUs: %s\n' \
    "$software_name" "$num_cpu" "$1"

# Compare the available CPUs with the minimum requirement
result=0
if [ "$num_cpu" -lt "$1" ]; then
    printf 'Error: insufficient CPUs for %s.\n' "$software_name"
    result=1
else
    printf 'OK: CPU requirement met for %s.\n' "$software_name"
fi

# Explain the two chosen commands
printf '\nread collects the software name, making the check specific to your application.\n'
printf 'printf formats the name, CPU counts, and result into a clear report.\n'

exit "$result"
