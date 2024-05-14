#!/bin/bash -x

TT="Installazione e configurazione X11"
filename="./sysconf.d"
ff=$(basename "$0")
ff="${ff%.*}"
FROM=./sysconf.d/home
TO="/home/$UTENTE"


whiptail --title "$TT" --msgbox "Installazione pacchetti base X11" $NN

clear
read
apt   --yes install  $(< $ff.lst )

read
dpkg -i ./packages.d/com.github.johnfactotum.foliate_2.6.4_all.deb
apt -f -y install


whiptail --title "$TT" --msgbox "Installazione app menu Openbox" $NN

clear
read
install -b -D -g$UTENTE -o$UTENTE $FROM/local/bin/obdevicemenu	$TO/.local/bin
install -b -D -g$UTENTE -o$UTENTE $FROM/local/bin/obamenu.py	$TO/.local/bin

read
chmod 755 $TO/local/bin/*


whiptail --title "$TT" --msgbox "Configurazione Openbox e applicativi" $NN

clear
read
install -b -d -g$UTENTE -o$UTENTE $TO/.config/doublecmd/
install -b -d -g$UTENTE -o$UTENTE $TO/.config/dunst/
install -b -d -g$UTENTE -o$UTENTE $TO/.config/openbox/
install -b -d -g$UTENTE -o$UTENTE $TO/.config/rofi/
install -b -d -g$UTENTE -o$UTENTE $TO/.config/tilda/
install -b -d -g$UTENTE -o$UTENTE $TO/.config/xfe/

read
install -b -g$UTENTE -o$UTENTE $FROM/config/doublecmd/*	$TO/.config/doublecmd/
install -b -g$UTENTE -o$UTENTE $FROM/config/dunst/*	$TO/.config/dunst/
install -b -g$UTENTE -o$UTENTE $FROM/config/openbox/*	$TO/.config/openbox/
install -b -g$UTENTE -o$UTENTE $FROM/config/rofi/*	$TO/.config/rofi/
install -b -g$UTENTE -o$UTENTE $FROM/config/tilda/*	$TO/.config/tilda/
install -b -g$UTENTE -o$UTENTE $FROM/config/xfe/*	$TO/.config/xfe/
read
