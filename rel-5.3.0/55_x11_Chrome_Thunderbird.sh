#!/bin/bash

filename=$(basename "$0")
filename="${filename%.*}"
TT="Installazione CHROME e THUNDERBIRD"


whiptail --title "$TT" --msgbox "Aggiunta repository e Installazione pacchetti" $NN

clear
read
apt install -y gnupg

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

cat <<EOF >>/etc/apt/sources.list
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF

apt -y update
apt -y install  $(< $filename.lst )
read
