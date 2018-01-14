#!/bin/bash

vmname="windows10vm"

if ps -A | grep -q $vmname; then
   echo "$vmname is already running." &
   exit 1

else

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
  -m 8G \
  -mem-prealloc \
  -balloon none \
  -rtc clock=host,base=localtime \
  -vga none \
  -nographic \
  -serial none \
  -parallel none \
  -device vfio-pci,host=4d:00.0,multifunction=on \
  -device nec-usb-xhci,id=usb,bus=pci.0,addr=0x5 -device usb-host,vendorid=1118,productid=733 -device usb-host,vendorid=8916,productid=4886  -device usb-host,vendorid=1204,productid=61199 \
  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=/tmp/my_vars.fd \
  -drive file=../virtio-win-.iso,media=cdrom \
  -boot d -cdrom win10ltsb.iso \
  -boot order=dc \
  -device virtio-scsi-pci,id=scsi \
  -drive id=disk0,if=virtio,cache=none,format=raw,file=/opt/qemu_machines/windows/win.img \
  -soundhw hda \
  -drive id=disk1,if=virtio,cache=none,format=raw,file=/dev/disk/by-id/ata-Samsung_SSD_850_EVO_250GB_S21NNXCGA31291F
   exit 0
fi
