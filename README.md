# QEMU-config
A collection of scripts I use to setup passthrough and networking for QEMU. Install Synergy if you want simpler mouse and keyboard setup, otherwise remove synergy from run.sh

# Storage

I generally store images at `/opt/qemu_machines/machine/machine.img` and .isos at `/opt/qemu_machines/isos/*`, this can be changed however.

# Passthrough:

unbind.sh contains a list of PCI devices to passthrough to vfio-pci. Find the id of your PCI device via lspci

# Networking:

qemu-ifup configures the interface for the VM.

# Machine Structure:

* Each machine has a folder, ie: macOS, windows.
* Each machine has a `machine/start.sh` associated with it with different options for different boot types.
* start.sh is the default startup file.

# How to run with default options:

Enter the directory of selected machine, and enter `../run.sh`, enter password. This will create the networking interfaces and start synergy. Ensure that you've configured the start.sh file with the correct network adapter and settings.
