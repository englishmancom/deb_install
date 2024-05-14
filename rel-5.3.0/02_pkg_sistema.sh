#!/bin/bash

TT="Configurazione di sistema 2"
filename="./sysconf.d"
ff=$(basename "$0")
ff="${ff%.*}"



whiptail --title "$TT" --msgbox "UPGRADE pacchetti sistema" $NN

apt --yes update
apt --yes upgrade


whiptail --title "$TT" --msgbox "INSTALL pacchetti sistema" $NN

apt --yes install   $(< $ff.lst )


whiptail --title "$TT" --msgbox "PURGE pacchetti inutili" $NN

apt --yes purge $(< 02_pkg_purge.lst )


whiptail --title "$TT" --msgbox "Configurazione SSMTP" $NN

install -b $filename/etc/ssmtp/* /etc/ssmtp


whiptail --title "$TT" --msgbox "Configurazione CPUFREQUTIL" $NN

install -b $filename/etc/default/cpufrequtils /etc/default


whiptail --title "$TT" --msgbox "Disabilitazione servizio HDPARM e SMARTD" $NN

systemctl disable hdparmd 
systemctl disable smartd
systemctl stop hdparmd
systemctl stop smartd


whiptail --title "$TT" --msgbox "Configurazione sudoers, INVIO per continuare" $NN

cat <<EOF >>/etc/sudoers
%sudo	ALL=(ALL:ALL) NOPASSWD:ALL
EOF


whiptail --title "$TT" --msgbox "Detect sensori hardware" $NN

sensors-detect


whiptail --title "$TT" --msgbox "Configurazione RESOLVED" $NN

install -b $filename/etc/systemd/resolved.conf /etc/systemd/resolved.conf
mv /etc/resolv.conf /etc/resolv.conf.old
systemctl enable systemd-resolved
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl start systemd-resolved


whiptail --title "$TT" --msgbox "Abilitazione TIMESYNCD" $NN

systemctl enable systemd-timesyncd
systemctl start systemd-timesyncd


whiptail --title "$TT" --msgbox "Creazione DB per PLOCATE" $NN

updatedb.plocate
