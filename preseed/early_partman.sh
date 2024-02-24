#!/bin/sh
SYSHD_DISKS=
debconf-set partman-auto/disk "${SYSHD_DISKS}"
/mk_partman "${SYSHD_DISKS}" >partman.cfg

echo PARTMAN configuration:
cat partman.cfg
