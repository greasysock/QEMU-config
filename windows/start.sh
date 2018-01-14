]#!/bin/bash

vmname="windows10vm"

if ps -A | grep -q $vmname; then
   echo "$vmname is already running." &
   exit 1

else

../qemu-ifup eno1
../unbind.sh
export QEMU_AUDIO_DRV=pa
cp /usr/share/OVMF/OVMF_VARS.fd /tmp/my_vars.fd
cp /home/chris/.config/pulse/cookie /root/.config/pulse/cookie

../qemu-system-x86_64 \
  -name $vmname,process=$vmname \
  -machine type=pc-i440fx-2.5,accel=kvm \
  -cpu host,kvm=off \
  -smp 8,sockets=1,cores=4,threads=2 \
  -enable-kvm \
  -m 12G \
  -mem-prealloc \
  -balloon none \
  -rtc clock=host,base=localtime \
  -vga none \
  -nographic \
  -serial none \
  -parallel none \
  -soundhw hda \
  -device vfio-pci,host=4d:00.0,multifunction=on \
  -object input-linux,id=kbd,evdev=/dev/input/by-id/usb-HID_Keyboard_HID_Keyboard-event-kbd,grab_all=on,repeat=on \
  -object input-linux,id=mouse,evdev=/dev/input/by-id/usb-Laview_Technology_Mionix_Castor_STM32-event-mouse \
  -device nec-usb-xhci,id=usb,bus=pci.0,addr=0x5 -device usb-host,vendorid=1118,productid=733 -device usb-host,vendorid=2578,productid=0001 \
  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=/tmp/my_vars.fd \
  -cdrom /home/chris/projects/virtio-win-.iso \
  -boot order=dc \
  -device virtio-scsi-pci,id=scsi \
  -drive id=disk0,if=virtio,cache=none,format=raw,file=/opt/qemu_machines/windows/win.img \
  -device e1000,netdev=net0,mac=DE:AD:BE:EF:49:43 -netdev tap,id=net0 \
  -drive id=disk1,if=virtio,cache=none,format=raw,file=/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S21NNXCGA31291F
   exit 0
fi
