#! /bin/bash

updown && sudo tshark -i wlan1 -T json -a duration:60 | tee /home/pi/whodat/whodat.json | gron | egrep "frame.number|frame.time\"|radiotap.dbm_antsignal|channel.freq|wlan.ra|wlan.addr" | gron -ungron | tee | bat -l json -P | tee -a $HOME/whodat.json
