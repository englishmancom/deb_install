#!/bin/bash

filename=$(basename "$0")
filename="${filename%.*}"
TT="Laptop"

whiptail --title "$TT" --msgbox "Installazione pacchetti laptop" $NN

apt   --yes install  $(cat $filename.lst )


whiptail --title "$TT" --msgbox "Configurazione propedeutiche NETWORK MANAGER" $NN

mv /etc/network/interfaces /etc/network/interfaces.old
systemctl restart networking
systemctl restart network-manager

whiptail --title "$TT" --msgbox "Eseguire configurazione manuale NETWORK MANAGER" $NN

nmtui
