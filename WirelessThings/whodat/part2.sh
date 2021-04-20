r#sudo tshark -r *.pcap -T json | gron | egrep "frame.number|frame.time\"|radiotap.dbm_antsignal|channel.freq|ssid" | gron -ungron | tee -a ~/whodat/whodatout.txt
