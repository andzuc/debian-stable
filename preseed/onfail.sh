#!/bin/sh
echo ">>> SYSLOG"
cat /var/log/syslog
echo "<<< SYSLOG"

echo ">>> DF"
df -h
echo "<<< DF"
