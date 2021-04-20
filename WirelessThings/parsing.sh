
mv newprobez.txt oldprobez.txt

sudo tshark -r /root/.cache/termshark/pcaps/"$1" > newprobez.txt

diff newprobez.txt oldprobez.txt | bat -P | grep --color -o -Ei "((([0-9a-z_]{2,20}:{1}){2,5}[a-z0-9]{2})|ssid.*)" >> latest.txt

echo "//////" >> latest.txt
