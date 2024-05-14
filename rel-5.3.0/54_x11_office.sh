#!/bin/bash

filename=$(basename "$0")
filename="${filename%.*}"
TT="Installazione e configurazione app OFFICE e relative"
FROM=./sysconf.d/home
TO='/home/$UTENTE/.config'


whiptail --title "$TT" --msgbox "Installazione pacchetti" $NN

apt   --yes install  $(< $filename.lst )


whiptail --title "$TT" --msgbox "Configurazione utente App OFFICE" $NN

install -b -d -g$UTENTE -o$UTENTE $TO/.config/zim
install -b -g$UTENTE -o$UTENTE $FROM/config/zim/*	$TO/.config/zim
