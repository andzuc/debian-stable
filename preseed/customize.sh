#!/bin/sh
# credit https://stackoverflow.com/a/246128
MYDIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd)
export PATH="$PATH:$MYDIR"
cd "$MYDIR"

echo ">>> debconf-get-selections"
debconf-get-selections
echo "<<< debconf-get-selections"

DEBIAN_OS_VERSION="$(cat /etc/debian_version)"
echo DEBIAN_OS_VERSION="${DEBIAN_OS_VERSION}"

# https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/
# no password for vagrant user sudo
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/vagrant

sshsetup.sh \
    /home/vagrant \
    "$(cat vagrant.pub)" \
    vagrant vagrant

BOOTOPTS="consoleblank=0 elevator=noop scsi_mod.use_blk_mq=Y net.ifnames=0 biosdevname=0"
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1\"'"${BOOTOPTS}"'\"/g' /etc/default/grub
update-grub
