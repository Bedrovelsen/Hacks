#! /bin/bash


# Association request (subtype 0x0)
# Association response (subtype 0x1)
# Reassociation request (subtype 0x2)
# Reassociation response (subtype 0x3) # Probe request (subtype 0x4)
# Probe response (subtype 0x5)
# Beacon (subtype 0x8)
# ATIM (subtype 0x9)
# Disassociation (subtype 0xa)
# Authentication (subtype 0xb)
# Deauthentication (subtype 0xc) # Action (subtype 0xd)


#wlan.fc.type == 0
# wlan.fc.type_subtype == 0
# wlan.fc.type_subtype == 1
# wlan.fc.type_subtype == 2
# wlan.fc.type_subtype == 3
# wlan.fc.type_subtype == 4
# wlan.fc.type_subtype == 5
# wlan.fc.type_subtype == 8
# wlan.fc.type_subtype == 9
# wlan.fc.type_subtype == 10
# wlan.fc.type_subtype == 11
# wlan.fc.type_subtype == 12
# wlan.fc.type_subtype == 13

#wlan.fc.type == 0
# wlan.fc.type_subtype == 0
# wlan.fc.type_subtype == 1
# wlan.fc.type_subtype == 2
# wlan.fc.type_subtype == 3
# wlan.fc.type_subtype == 4
# wlan.fc.type_subtype == 5
# wlan.fc.type_subtype == 8
# wlan.fc.type_subtype == 9
# wlan.fc.type_subtype == 10
# wlan.fc.type_subtype == 11
# wlan.fc.type_subtype == 12
# wlan.fc.type_subtype == 13


sudo ifconfig wlan1 down
sudo iwconfig wlan1 mode monitor
sudo ifconfig wlan1 up
sudo termshark -i wlan1 -Y "wlan.fc.type == 0 && !wlan.fc.subtype == 8" ---no-duplicate-keys
#--pass-thru=auto --tty=/dev/tty1
