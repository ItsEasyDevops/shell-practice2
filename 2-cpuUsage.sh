#!/bin/bash

while true; 
do
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "Current CPU Usage: $CPU_USAGE%"
    sleep 1 
done