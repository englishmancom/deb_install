#!/bin/bash

TT="Installazione di SAMBA server"
ff=$(basename "$0")
ff="${ff%.*}"


whiptail --title "$TT" --msgbox "Installazione pacchetti" $NN

apt   --yes install   $(< $ff.lst )


whiptail --title "$TT" --msgbox "Ricordarsi di fare SMBPASS -a utente" $NN
