#!/bin/bash

if [ "$(id -u)" != "0" ]; then  #Check if script is being run as root
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [ ! $? = 0 ]; then
   exit 1
else
   echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
   echo "dwc2" | sudo tee -a /etc/modules
   echo "g_acm_ms" | sudo tee -a /etc/modules
   systemctl enable getty@ttyGS0.service
   idir="/opt/pishift"
   mkdir "$idir"
   mkdir "$idir/binaries"
   mkdir "$idir/programs"
   mkdir "$idir/scripts"
   touch "$idir/programs/test.txt"
   binf="$idir/binaries/ms.bin"
   dd if=/dev/zero of="$binf" bs=512 count=2880
   mkdosfs "$binf"
   cp -a services/. /etc/systemd/system/
   cp -a scripts/. "$idir/scripts/"
   for filename in services/*.service; do
       name=${filename##*/}
       systemctl enable $name
   done
   whiptail --title "Installation complete" --msgbox "piShift installation complete. You can now safely shutdown your Raspberry Pi and insert the micro SD card into your Raspberry Pi Zero." 8 78
fi
