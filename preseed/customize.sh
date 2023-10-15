#!/bin/sh
# credit https://stackoverflow.com/a/246128
MYDIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &>/dev/null && pwd)
export PATH="$PATH:$MYDIR"

# https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/
# no password for vagrant user sudo
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/vagrant

sshsetup \
    /home/vagrant \
    "$(cat vagrant.pub)" \
    vagrant vagrant
