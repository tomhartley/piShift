#!/bin/sh -e

sudo modprobe g_acm_ms luns=2 file=/piusb.bin,/outputusb.bin ro=0,1 stall=0

exit 0
