#!/bin/sh
# https://serverfault.com/a/528605
echo "Start setmirror.sh runscript" >> /var/log/syslog
for x in `cat /proc/cmdline`; do
        case $x in RPHOST*)
                eval $x
                HOST=$RPHOST
                echo "d-i mirror/http/hostname string ${HOST}" > /tmp/mirror.cfg
                echo "d-i mirror/http/mirror string ${HOST}" >> /tmp/mirror.cfg
                echo "d-i apt-setup/security_host string ${HOST}" >> /tmp/mirror.cfg
                ;;
        esac;
done
# add's values to /var/lib/cdebconf/question.dat
debconf-set-selections /tmp/mirror.cfg
