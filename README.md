<img src="https://raw.githubusercontent.com/tomhartley/piShift/master/images/logo.png" width="100">

piShift makes it super simple to get programming on your Pi Zero - just plug your Pi into your laptop with a micro-USB cable and it appears as a USB Drive. Drag across a .py file, and within seconds the Pi will automatically detect it's been added, and will start running the most recently edited file.

#Installation

0. Setup your Pi Zero with Andrew's guide here: http://blog.gbaman.info/?p=699
1. Make sure to follow Andrew's guide on how to set up images for use with g_mass_storage.
    Make two images, /piusb.bin and /outputusb.bin

1. Make a folder, /home/pi/piShift/
2. Put pishift.py inside that folder
3. Put startmod.sh inside that folder
4. Move the two .service files to the /etc/systemd/system


Hopefully in the future it should be easier to get this up and running!