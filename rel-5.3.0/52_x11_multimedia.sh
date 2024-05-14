#!/bin/bash

filename=$(basename "$0")
filename="${filename%.*}"
TT="Repository Debian multimedia"


whiptail --title "$TT" --msgbox "Configurazione repository e upgrade pacchetti" $NN

cat <<EOF >>/etc/apt/sources.list
deb http://debian.lth.se/debian-multimedia/ testing main
EOF

wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
apt -y update
apt -y upgrade


whiptail --title "$TT" --msgbox "Installazione pacchetti aggiuntivi" $NN

apt   --yes install  $(< $filename.lst )
