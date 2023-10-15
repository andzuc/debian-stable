#!/bin/sh
echo "vagrant ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/vagrant

# gpg
apt-install gpg

# zsh
apt-install zsh; in-target chsh -s /bin/zsh
