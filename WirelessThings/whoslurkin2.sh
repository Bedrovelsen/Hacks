#! /bin/bash

updown
tshark -i wlan1 -T json -a duration:65 | gron | egrep "frame.number|frame.time\"|radiotap.dbm_antsignal|channel.freq|wlan.ra|wlan.addr" | gron -ungron | tee -a /home/pi/whodat.json | bat -l json -P
