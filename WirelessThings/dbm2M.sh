#! /bin/bash
echo "[Meters]" && bash -c "bc <<< \"scale=4; ((-69.0 + ("$1")) / 27.0)/-1\""

#echo "[Feet]" && bash -c "bc <<< \"scale=4; (((-69.0 + ("$1")) / 27.0)/-1)*3.281\""

echo " "
