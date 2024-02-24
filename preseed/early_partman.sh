#!/bin/sh
echo ">>> BLOCKDEVS"
ls -l /sys/block/*
echo "<<< BLOCKDEVS"
SYSHD_DISKS=
debconf-set partman-auto/disk "${SYSHD_DISKS}"
/mk_partman "${SYSHD_DISKS}" >partman.cfg

echo PARTMAN configuration:
cat partman.cfg
