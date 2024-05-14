#!/bin/bash

TT="Repository Debian multimedia"
filename=$(basename "$0")
filename="${filename%.*}"


whiptail --title "$TT" --msgbox "Installazione BLUETOOTH e PULSEAUDIO" $NN

apt   --yes install  $(< $filename.lst )
