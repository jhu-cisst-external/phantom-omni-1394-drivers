# Introduction

The goal of these notes is to document how to install the Phanton Omni drivers (for the FireWire version, i.e. 1394)
as well as the OpenHaptics SDK (education version) on Ubuntu.  This was
successfuly tested on Ubuntu 16.04, 18.04 and 20.04 LTS 64 bits.

The approach of this install is to use the default `.deb` files, avoid copying/moving files and creating symbolic links as much as possible

This can be used in combination with https://github.com/jhu-saw/sawSensablePhantom.  The `devel` branch has ROS support for the Phantom Omni.

To install the drivers and SDK for a more recent GeoMagic/3DS Touch device, see also https://github.com/jhu-cisst-external/3ds-touch-openhaptics

# Instructions

First download this repository.  Then use the script as described below.  The script will:
  * In directory `files`, uncompress all archives (`.tgz` and `.zip`)
  * Using `dpkg`, install the two `.deb` files provided by the vendor (driver
    and SDK)
  * Remove all `libPHANToMIO.so*` files and replace them with those provided in
    the `JUJU` archives along with new symbolic links
  * Configure your system to find the shared libraries in `/usr/lib64`
  * Configure your permissions for the FireWire port
  
Install script (you will need sudo privileges):
```bash
   mkdir -p ~/phantom-omni-1394-drivers     # get the files
   cd ~/phantom-omni-1394-drivers
   git clone https://github.com/jhu-cisst-external/phantom-omni-1394-drivers
   cd ~/phantom-omni-1394-drivers/phantom-omni-1394-drivers
   sudo ./install-omni-drivers.sh # finally run the install script
   sudo rm -rf Linux_JUJU_PDD_64-bit OpenHapticsAE_Linux_v3_0  # this is just to clean temporary files
```

To remove all files:
```bash
   cd ~/phantom-omni-1394-drivers/phantom-omni-1394-drivers
   sudo ./uninstall-omni-drivers.sh
```

# Other dependencies

The drivers come with two executables: `PHANToMConfiguration` and `PHANToMTest`.
The test program is compiled against libraw1394.so.8 which is not available on Ubuntu 16.04, 18.04 or 20.04 so it's hard to get it working.
The configuration utility works but you might need to install `libGLs`.  It can be installed using apt with `sudo apt install libglw-mesa` on Ubuntu 16.04 or `sudo apt install libglw1-mesa` on Ubuntu 18.04 and 20.04.

# Configuration

Use the program `PHANTOMConfiguration` *with sudo privileges*.   Click "Add", enter a name for the device, select the arm type (i.e. Omni) and then clicj "Apply" and "OK" to quit. 

# Notes

## Documentation

There's a document detailling how to install the drivers that is included in the drivers (catch 22).  Once you installed the drivers, you can find the vendor's instructions on your PC:
```sh
evince /usr/share/PHANTOM/doc/HW_userguide_Linux.pdf
```

## Links

The following repositories have been used to compile these instructions:
  * https://github.com/jaejunlee0538/sensable_phantom_in_linux
  * https://github.com/adeguet1/phantom_omni
    (fork of https://github.com/fsuarez6/phantom_omni)
  * https://github.com/MurpheyLab/trep_omni
  * http://robotics.mech.northwestern.edu/%7Ejarvis/omni-install.md

## Comments

  * I have no clue where the JUJU binaries come from.  They are different (different size, `cksum` and `ldd`) and they're not stripped.
  * In the install script I added a step to strip the binaries
  * Using `ldd` I found that the main difference between the `libPHANToM.so.4.3` provided by the vendor and the JUJU one is that the vendor one depends on `libraw1394.so.8` while the JUJU one depends on `libraw1394.so.11`.  Since `libraw1394` is already at version 11 there's no need to create a symbolic link (as seen on some howto) found on the web.
  * For the firewire port permissions, I used the group `plugdev` as suggested in one of the readme found online.   Don't forget to add each user to the `plugdev` group using `sudo adduser user_name_here plugdev`.  Users have to login after being added to the group. 
