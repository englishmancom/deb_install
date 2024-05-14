#!/bin/bash

export UTENTE="popi"
export NN="8 78"

apt install -y whiptail

while true
do

	SCELTA=$(whiptail --title "Menu di installazione"\
		--menu "Scegli una opzione" 25 78 16 \
		"01_sysconf.sh" "Prima parte configurazione sistema" \
		"02_pkg_sistema.sh" "Seconda parte configurazione sistema" \
		"31_laptop.sh" "Pacchetti e configurazioni aggiuntivi Laptop" \
		"41_configurazioni_utente.sh" "Creazione e configurazione utente" \
		"42_samba-client.sh" "Samba client per desk e server" \
		"51_x11_base.sh" "X11 pacchetti base" \
		"52_x11_multimedia.sh" "X11 pacchetti multimedia" \
		"53_x11_bluetooth.sh" "X11 pacchetti bluetooth" \
		"54_x11_office.sh" "X11 pacchetti Office" \
		"55_x11_Chrome_Thunderbird.sh" "X11 pacchetti Internet" \
		"91_samba-server.sh" "Samba server" \
		"92_exim4.sh" "Mail server (Exim4)" \
		"93_zfs.sh" "ZFS server" \
		"94_bind9.sh" "Name server (Bind9)" \
		3>&1 1>&2 2>&3)

	exitstatus=$?

	if [ $exitstatus != 0 ]; then
		exit
	fi

	./$SCELTA

done
