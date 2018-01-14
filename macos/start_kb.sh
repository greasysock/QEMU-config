#!/bin/bash

# See https://www.mail-archive.com/qemu-devel@nongnu.org/msg471657.html thread.
#
# The "pc-q35-2.4" machine type was changed to "pc-q35-2.9" on 06-August-2017.
#
# The "media=cdrom" part is needed to make Clover recognize the bootable ISO
# image.

##################################################################################
# NOTE: Comment out the "MY_OPTIONS" line in case you are having booting problems!
##################################################################################

MY_OPTIONS="+aes,+xsave,+avx,+xsaveopt,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe"
../qemu-ifup eno1
../unbind.sh
~/QEMU/bin/qemu-system-x86_64 -enable-kvm -m 12G -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,$MY_OPTIONS\
	  -mem-prealloc \
	  -machine pc-q35-2.9 \
	  -smp 4,cores=4 \
	  -usb -device usb-kbd -device usb-tablet \
	  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
	  -drive if=pflash,format=raw,readonly,file=OVMF_CODE.fd \
          -serial none \
          -parallel none \
	  -drive if=pflash,format=raw,file=OVMF_VARS.fd \
          -device vfio-pci,host=4d:00.0,multifunction=on \
	  -smbios type=2 \
	  -device ich9-intel-hda -device hda-duplex \
          -object input-linux,id=kbd,evdev=/dev/input/by-id/usb-HID_Keyboard_HID_Keyboard-event-kbd,grab_all=on,repeat=on \
          -usb -device usb-host,hostbus=7,hostaddr=7 \
	  -device ide-drive,bus=ide.1,drive=MacHDD \
	  -drive id=MacHDD,if=none,file=/opt/qemu_machines/macos/mac.img,format=raw \
	  -boot order=ac \
          -device e1000-82545em,netdev=net0,mac=52:54:00:AB:F6:EF -netdev tap,id=net0 \
	  -vga none \
	  -nographic
