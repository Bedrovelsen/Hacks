#! /bin/bash

sudo ifconfig wlan1 down && sudo iwconfig wlan1 mode managed && sudo ifconfig wlan1 up && sudo bettercap -iface wlan1 -caplet hu.cap

#-eval "set events.stream.output /home/pi/hudat/probez.txt;wifi.recon on"

#sudo bettercap -iface wlan1 -caplet hu.cap
