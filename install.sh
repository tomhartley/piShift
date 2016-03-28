#!/bin/bash

if [ "$(id -u)" != "0" ]; then  #Check if script is being run as root
   echo $"This script must be run as root" 1>&2
   exit 1
fi

sudo BRANCH=next rpi-update
echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
echo "dwc2" | sudo tee -a /etc/modules
echo "g_acm_ms" | sudo tee -a /etc/modules
idir = "/opt/pishift"
mkdir "$idir"
mkdir "$idir/binaries"
binf = "$idir/binaries/ms.bin"
mkdir "$idir/scripts"
dd if=/dev/zero of="$binf" bs=512 count=2880
mkdosfs "$binf"
cp -r scripts/ "$idir/scripts/"
cp -r services/ /etc/systemd/system/
for filename in services/*.service; do
    name=${filename##*/}
    systemctl enable $name
done