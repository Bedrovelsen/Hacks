grep -o -Ei "\-[0-9]{2}" latest.txt | sort -u | tee db.txt | xargs -I _ sh -c "dbm2M _ && echo '_' && echo" > ntrst.txt && vim -c ":%s/\n-/ -/g|:wq" ntrst.txt && cat ntrst.txt | xargs -I _ echo "echo \"_\"" | awk '{printf $1" "$2"\n"}'

grep -o -Ei "\-[0-9]{2}" latest.txt | sort -u | tee db.txt | xargs -I _ sh -c "dbm2M _ && echo '_' && echo" > ntrst.txt && vim -c ":%s/\n-/ -/g|:wq" ntrst.txt && cat ntrst.txt | xargs -I _ "echo _ | awk '{printf $1}'"
