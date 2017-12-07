#!/usr/bin/env bash

# Anton Deguet anton.deguet@jhu.edu
# 2017-12-07

# this script will only handle 64 bits OSs

# some ubuntu requirements
sudo apt-get install libglw1-mesa-dev libraw1394-11-dev libraw1394-dev libgl1-mesa-glx libgl1-mesa-dri

# remove uncompressed files from previous runs of this script
rm -rf Linux_JUJU_PDD_64-bit OpenHapticsAE_Linux_v3_0

# first unzip OpenHaptics to find all .deb to install
unzip ./files/OpenHapticsAE_Linux_v3_0.zip

# install .deb files
dpkg -i "OpenHapticsAE_Linux_v3_0/PHANTOM Device Drivers/64-bit/phantomdevicedrivers_4.3-3_amd64.deb"
dpkg -i "OpenHapticsAE_Linux_v3_0/OpenHaptics-AE 3.0/64-bit/openhaptics-ae_3.0-2_amd64.deb"

# use JUJU patch to replace libPHANToM
tar zxvf ./files/Linux_JUJU_PDD_64-bit.tgz
rm -f /usr/lib64/libPHANToMIO.so*
rm -f /usr/sbin/PHANToMConfiguration

# for some reason the JUJU binaries are not stripped
strip ./Linux_JUJU_PDD_64-bit/libPHANToMIO.so.4.3
strip ./Linux_JUJU_PDD_64-bit/PHANToMConfiguration
cp  ./Linux_JUJU_PDD_64-bit/libPHANToMIO.so.4.3 /usr/lib64
ln -s /usr/lib64/libPHANToMIO.so.4.3 /usr/lib64/libPHANToMIO.so.4
ln -s /usr/lib64/libPHANToMIO.so.4.3 /usr/lib64/libPHANToMIO.so
cp ./Linux_JUJU_PDD_64-bit/PHANToMConfiguration /usr/sbin

# configure ld.conf and reload ld conf
echo "/usr/lib64" > /etc/ld.so.conf.d/openhaptics.conf
ldconfig

# configure udev rules for firewire device, adds rw-rw---- permission to group plugdev
echo "SUBSYSTEM==\"firewire\", ATTR{vendor}==\"0x000b99\", MODE=\"0660\", GROUP=\"plugdev\"" > /lib/udev/rules.d/50-phantom-firewire.rules
udevadm control --reload-rules
