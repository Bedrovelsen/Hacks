#! /bin/bash
screen -dmLS bcstart "sudo ifconfig wlan1 down && sudo iwconfig wlan1 mode managed && sudo ifconfig wlan1 up && sudo bettercap -iface wlan1 -caplet hu.cap" && echo "" && screen -dmLS parse ./dalo.sh && screen -dmLS loop ./newpar.sh
