#!/bin/bash 

FROM=./sysconf.d/home
TO="/home/$UTENTE"
TT="Creazione e configurazione utente"


whiptail --title "$TT" --msgbox "Creazione utente" $NN

adduser $UTENTE
usermod -G cdrom,floppy,sudo,audio,dip,video,plugdev,users,netdev $UTENTE


whiptail --title "$TT" --msgbox "Configurazione utente" $NN

install -b -D -g$UTENTE -o$UTENTE $FROM/bashrc		$TO/.bashrc
install -b -D -g$UTENTE -o$UTENTE $FROM/dircolors	$TO/.dircolors
install -b -D -g$UTENTE -o$UTENTE $FROM/inputrc		$TO/.inputrc

install -b -d -g$UTENTE -o$UTENTE $TO/.config/htop
install -b -d -g$UTENTE -o$UTENTE $TO/.config/mc
install -b -d -g$UTENTE -o$UTENTE $TO/.config/neofetch

install -b -g$UTENTE -o$UTENTE $FROM/config/htop/*	$TO/.config/htop/
install -b -g$UTENTE -o$UTENTE $FROM/config/mc/*	$TO/.config/mc/
install -b -g$UTENTE -o$UTENTE $FROM/config/neofetch/*	$TO/.config/neofetch/

