# Introduction

The goal of these notes is to document how to install the Phanton Omni drivers
as well as the OpenHaptics SDK (education version) on Ubuntu.  This was
successfuly tested on Ubuntu 16.04 LTS 64 bits.

The goal of this install is to use the default `.deb` files as much as possible
and avoid copying/moving files and links across directories as much as possible.

# Instructions

In plain english:
  * Download this repository
  * In directory `files`, uncompress all archives (`.tgz` and `.zip`)
  * Using `dpkg`, install the two `.deb` files provided by the vendor (driver
    and SDK)
  * Remove all `libPHANToMIO.so*` files and replace them with those provided in
    the `JUJU` archives along with new symbolic links
  * Configure your system to find the shared libraries in `/usr/lib64`
  * Configure your permissions for the FireWire port
  
In script (you will need sudo privileges):
```bash
   mkdir -p ~/jhu-phantom-omni-drivers     # get the files
   cd ~/jhu-phantom-omni-drivers
   git clone https://git.lcsr.jhu.edu/phantom-omni/drivers
   cd ~/jhu-phantom-omni-drivers/drivers
   sudo ./install-jhu-omni-drivers.sh
```
   

# Notes

## Links

The following repositories have been used to compile these instructions:
  * https://github.com/adeguet1/sensable_phantom_in_linux
    (fork of https://github.com/jaejunlee0538/sensable_phantom_in_linux)
  * https://github.com/adeguet1/phantom_omni
    (fork of https://github.com/fsuarez6/phantom_omni)