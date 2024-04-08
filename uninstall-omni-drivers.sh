#!/usr/bin/env bash

# Anton Deguet anton.deguet@jhu.edu
# 2017-12-07

# create directory so post script doesn't fail
mkdir -p /usr/share/3DTouch
touch  /usr/share/3DTouch/dummy

# uninstall deb packages
apt-get remove --yes --show-progress openhaptics-ae
apt-get remove --yes --show-progress phantomdevicedrivers

# remove files copied manually from JUJU
rm -f /usr/lib64/libPHANToM.so*
rm -f /usr/sbin/PHANToMConfiguration

# remove OS configuration files
rm -f /etc/ld.so.conf.d/openhaptics.conf
rm -f /lib/udev/rules.d/50-phantom-firewire.rules
udevadm control --reload-rules
