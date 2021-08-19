#!/bin/sh
onterm()
{
    echo ">>> SYSLOG"
    cat /var/log/syslog
    echo "<<< SYSLOG"
}

trap onterm 15

sleep 1d
