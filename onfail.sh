#!/bin/sh
onterm()
{
    echo ">>> SYSLOG" >/dev/console
    cat /var/log/syslog >/dev/console
    echo "<<< SYSLOG" >/dev/console
}

trap onterm 15

sleep 1d
