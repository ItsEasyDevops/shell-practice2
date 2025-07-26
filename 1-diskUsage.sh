#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1 # In actual projects, this should be set to a percentage like 80 for 80%
MSG=""
IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)


while IFS= read line 
do
  USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1)
  PARTITION=$(echo $line | awk '{print $7F}')
  echo "$PARTITION : $USAGE%"
  if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="Disk usage on $PARTITION is high: $USAGE%\n"
    fi

done <<< $DISK_USAGE

sh mail.sh "DevOps Team" "Disk Usage Alert" "$IP" "$MSG" "mahenderkern@gmail.com" "Disk Usage Alert on $IP"