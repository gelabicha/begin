CPU=($(head -n 1 /proc/stat | awk '{for (i=2; i<=NF; i++) print $i}'))

# დაიანგარიშეთ საერთო და აქტიური დროები
IDLE=${CPU[3]} # idle
IOWAIT=${CPU[4]} # iowait
ACTIVE=$(( ${CPU[0]} + ${CPU[1]} + ${CPU[2]} + ${CPU[5]} + ${CPU[6]} + ${CPU[7]} ))
TOTAL=$(( ACTIVE + IDLE + IOWAIT ))

# გამოთვალეთ გამოყენების პროცენტი
USAGE=$(( 100 * ACTIVE / TOTAL ))

echo "Total CPU Usage: $USAGE%"






# წაიკითხეთ მონაცემები /proc/meminfo-დან
TOTAL_MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
FREE_MEM=$(grep MemFree /proc/meminfo | awk '{print $2}')
BUFFERS=$(grep Buffers /proc/meminfo | awk '{print $2}')
CACHED=$(grep ^Cached /proc/meminfo | awk '{print $2}')

# გამოთვალეთ გამოყენებული მეხსიერება
USED_MEM=$((TOTAL_MEM - FREE_MEM - BUFFERS - CACHED))

# გამოთვალეთ პროცენტი
USED_PERCENT=$((100 * USED_MEM / TOTAL_MEM))
FREE_PERCENT=$((100 - USED_PERCENT))

# შედეგის გამოქვეყნება MB-ებში და პროცენტებში
echo "Total Memory: $((TOTAL_MEM / 1024)) MB"
echo "Used Memory: $((USED_MEM / 1024)) MB ($USED_PERCENT%)"
echo "Free Memory: $((FREE_MEM / 1024)) MB ($FREE_PERCENT%)"


#!/bin/bash

# აიღეთ დისკის მონაცემები root ფაილური სისტემიდან
DISK_INFO=$(df -h / | tail -n 1)

# გამოიტანეთ მონაცემები
TOTAL_DISK=$(echo $DISK_INFO | awk '{print $2}')
USED_DISK=$(echo $DISK_INFO | awk '{print $3}')
FREE_DISK=$(echo $DISK_INFO | awk '{print $4}')
USED_PERCENT=$(echo $DISK_INFO | awk '{print $5}')

# შედეგის გამოქვეყნება
echo "Total Disk Size: $TOTAL_DISK"
echo "Used Disk: $USED_DISK ($USED_PERCENT)"
echo "Free Disk: $FREE_DISK"



#!/bin/bash

echo "Top 5 Processes by CPU Usage:"
echo "-----------------------------------"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6



#!/bin/bash

echo "Top 5 Processes by Memory Usage:"
echo "-----------------------------------"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6


