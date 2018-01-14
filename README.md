# QEMU-config
A collection of scripts I use to setup passthrough and networking for QEMU. Install Synergy if you want simpler mouse and keyboard setup, otherwise remove synergy from run.sh

# Passthrough:

* unbind.sh contains a list of PCI devices to passthrough to vfio-pci. Find the id of your PCI device via lspci

# Networking:

* qemu-ifup configures the interface for the VM.

# Machine Structure:

* Each Machine has a folder, ie: macOS, windows.
* Each Machine has a folder/start.sh associated with it with different options associated with it.
* start.sh is the default startup file.

# How to run with default options:

* Enter the directory of selected machine, and enter ../run.sh, enter password. This will create the networking interfaces and start synergy. Ensure that you've configured the start.sh file with the correct network adapter.
