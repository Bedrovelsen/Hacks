#!/bin/bash

sudo ifconfig wlan1 down
sudo iwconfig wlan1 mode monitor
sudo ifconfig wlan1 up
sudo termshark -i wlan1 -Y "wlan.fc.type == 0 && !wlan.fc.subtype == 8" 
