#!/bin/bash

# Get the CPU usage as a percentage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Check the CPU usage and format the output accordingly
if (( $(echo "$CPU_USAGE < 10" | bc -l) )); then
    printf "    %.0f%%\n" $CPU_USAGE
elif (( $(echo "$CPU_USAGE < 100" | bc -l) )); then
    printf "  %.0f%%\n" $CPU_USAGE
else
    printf "%.0f%%\n" $CPU_USAGE
fi

