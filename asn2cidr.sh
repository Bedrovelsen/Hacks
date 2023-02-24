#! /bin/bash

# setup/requirements
#
# bgp.tools provides two handy files asns.csv and table.txt
#   grab a copy of each.
# 
# please do not download table.txt more often than 30 mins,
#  Likely you are best off caching it for 2~ hours depending
#  on your requirements.
# 
# wget https://bgp.tools/table.txt
# 
# The suggested time to cache asns.csv is 24 hours. Changes
#   are unlikely to take place sooner than that. This file
#   also applies all of the custom name change edits that
#   happen on bge.tools. 
# 
# wget https://bgp.tools/asns.csv

grep -Ei "$1" asns.csv > netblks.txt;

grep -Ei -o '^AS[0-9]*' netblks.txt | sed 's#AS##g' | xargs -I {} grep -Ei ' {}$' table.txt > orgs.txt;

awk '{print "grep "$2" netblks.txt | xargs -I {} echo \"{} "$1" \""}' < orgs.txt  | bash | tee cidrs.txt
