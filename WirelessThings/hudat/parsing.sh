#! /bin/bash

mv newp.txt oldp.txt

cat probez.txt | awk -F "] " '{printf $3"\n"}' | grep -v -e "^\[" > newp.txt

echo "[+] Latest Wifi [+]]" > latest.txt

diff -w oldp.txt newp.txt | sed 's/> //g' | grep -v -e "^[0-9]" >> latest.txt

(grep -o -Ei "\-[0-9]{1,3}" latest.txt | xargs -I _ dbm2M _) | sort -u >>  dist.txt

echo "-parsed-"
