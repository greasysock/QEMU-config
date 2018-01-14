#!/bin/bash

DEVLIST="0000:4d:00.0 0000:4d:00.1"

for dev in $DEVLIST

do

vendor=$(cat /sys/bus/pci/devices/$dev/vendor)

device=$(cat /sys/bus/pci/devices/$dev/device)

if [ -e /sys/bus/pci/devices/$dev/driver ]

then

echo $dev > /sys/bus/pci/devices/$dev/driver/unbind

fi

echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id

done

