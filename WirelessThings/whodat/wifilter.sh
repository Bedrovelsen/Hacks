#! /bin/bash

echo "tshark -r $1 -T json | gron | egrep \"frame.number|frame.time\\\"|radiotap.dbm_antsignal|channel.freq|ssid\" | gron -ungron"
