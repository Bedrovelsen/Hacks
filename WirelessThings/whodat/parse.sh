tshark -T json -r wlan1--2021-03-24--18-53-39.pcap | gron | egrep "frame.number|frame.time\"|radiotap.dbm_antsignal|channel.freq|ssid" | gron -ungron 
