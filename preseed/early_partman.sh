#!/bin/sh
list-devices disk
SYSHD_DISKS="$(echo $(list-devices disk)|tr -d '\n')"
echo SYSHD_DISKS="${SYSHD_DISKS}"
debconf-set partman-auto/disk "${SYSHD_DISKS}"
/mk_partman "${SYSHD_DISKS}" >partman.cfg

echo PARTMAN configuration:
cat partman.cfg
