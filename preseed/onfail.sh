#!/bin/sh
echo ">>> SYSLOG"
cat /var/log/syslog
echo "<<< SYSLOG"

echo ">>> DISKS"
lsblk --output NAME,HCTL,FSTYPE,LABEL,UUID,MODE,FSUSE%,FSSIZE,SIZE
df -h
parted -l
echo "<<< DISKS"
