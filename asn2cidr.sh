#! /bin/bash

# setup/requirements
#
# bgp.tools provides two handy files at bgp.tools/asns.csv and bgp.tools/table.txt
# 
# grab a copy of each with wget.
#
# wget https://bgp.tools/table.txt
# wget https://bgp.tools/asns.csv


grep -Ei "$1" asns.csv > netblks.txt;

grep -Ei -o '^AS[0-9]*' netblks.txt | sed 's#AS##g' | xargs -I {} grep -Ei ' {}$' table.txt > orgs.txt;

awk '{print "grep "$2" asns.csv | xargs -I {} echo \"{} "$1" \""}' < orgs.txt  | bash | tee cidrs.txt
