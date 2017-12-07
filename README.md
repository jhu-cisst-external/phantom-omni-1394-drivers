# Introduction

The goal of these notes is to document how to install the Phanton Omni drivers
as well as the OpenHaptics SDK (education version) on Ubuntu.  This was
successfuly tested on Ubuntu 16.04 LTS 64 bits.

The approach of this install is to use the default `.deb` files as
much as possible and avoid copying/moving files and links across
directories as much as possible.  An alternative solution would be to
extract all the files and create a separate archive/tree that could be
installed under /opt to isolate all the Phantom files.

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

To remove all files:
```bash
   cd ~/jhu-phantom-omni-drivers/drivers
   sudo ./uninstall-jhu-omni-drivers.sh
```

# Notes

## Links

The following repositories have been used to compile these instructions:
  * https://github.com/adeguet1/sensable_phantom_in_linux
    (fork of https://github.com/jaejunlee0538/sensable_phantom_in_linux)
  * https://github.com/adeguet1/phantom_omni
    (fork of https://github.com/fsuarez6/phantom_omni)
  * https://github.com/MurpheyLab/trep_omni

## Comments

  * I have no clue where the JUJU binaries come from.  They are different (different size, `cksum` and `ldd`) and they're not stripped.
  * In the install script I added a step to strip the binaries
  * Using `ldd` I found that the main difference between the `libPHANToM.so.4.3` provided by the vendor and the JUJU one is that the vendor one depends on `libraw1394.so.8` while the JUJU one depends on `libraw1394.so.11`.  Since `libraw1394` is already at version 11 there's no need to create a symbolic link (as seen on some howto) found on the web.
  * For the firewire port permissions, I used the group `plugdev` as suggested in one of the readme found online.   Don't forget to add each user to the `plugdev` group using `sudo adduser user_name_here plugdev`.  Users have to login after being added to the group. 