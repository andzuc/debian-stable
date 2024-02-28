#!/bin/sh
# credit https://stackoverflow.com/a/246128
MYDIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd)
export PATH="$PATH:$MYDIR"
cd "$MYDIR"

echo ">>> KERNEL"
ls /boot
cat /boot/confi*
modprobe 9p
modprobe 9pnet
modprobe 9pnet_virtio
mkdir shared
mount -t 9p -o trans=virtio shared shared -oversion=9p2000.L
cp -a /boot shared
echo "<<< KERNEL"

echo ">>> debconf-get-selections"
debconf-get-selections
echo "<<< debconf-get-selections"

# Write out debian os version to evaluate IMAGE_VERSION
DEBIAN_OS_VERSION="$(cat /etc/debian_version)"
echo DEBIAN_OS_VERSION="${DEBIAN_OS_VERSION}"
IMAGE_SUBVERSION="$(cat /proc/cmdline|sed -En 's/.*IMAGE_SUBVERSION=([^ ]*).*/\1/p'|tr -d '\n')"
echo DEBIAN_IMAGE_VERSION="${DEBIAN_OS_VERSION}.${IMAGE_SUBVERSION}"|tee /etc/image_version

echo ">>> DISKS"
echo "lspci -tv"
lspci -tv
echo "lsblk --output NAME,HCTL,FSTYPE,LABEL,UUID,MODE,FSUSE%,FSSIZE,SIZE"
lsblk --output NAME,HCTL,FSTYPE,LABEL,UUID,MODE,FSUSE%,FSSIZE,SIZE
echo "df -h"
df -h
echo "parted -l"
parted -l
echo vgdisplay
vgdisplay
echo lvdisplay
lvdisplay
echo pvdisplay
pvdisplay
echo "<<< DISKS"

# https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/
# no password for vagrant user sudo
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/vagrant

# disable PAM access for vagrant user
# see https://superuser.com/a/603334
sed -Ei 's|(vagrant):([^:]*):(.*)|\1:\*:\3|g' /etc/shadow
sed -Ei 's|#\s*(account\s*required\s*pam_access\.so.*)|\1|g' /etc/pam.d/login
echo "-:vagrant:ALL" >>/etc/security/access.conf

# Setup vagrant pubkey
sshsetup.sh \
    /home/vagrant \
    "$(cat vagrant.pub)" \
    vagrant vagrant

# Setup kernel boot parameters
BOOTOPTS="consoleblank=0 elevator=noop scsi_mod.use_blk_mq=Y net.ifnames=0 biosdevname=0"
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1\"'"${BOOTOPTS}"'\"/g' /etc/default/grub
update-grub

# better compression: https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
