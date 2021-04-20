#! /bin/bash
echo "taking wlan1 down"
sudo ifconfig wlan1 down
echo "turning wlan1 into a spy"
sudo iwconfig wlan1 mode monitor
echo "brinigng wlan1 back up"
sudo ifconfig wlan1 up
echo "DONE"
