#!/bin/sh -e

sudo modprobe g_acm_ms luns=1 file=/opt/pishift/binaries/ms.bin ro=0 stall=0

exit 0
