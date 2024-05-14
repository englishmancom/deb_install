#!/bin/bash

f1="./sysconf.d"
TT="Installazione e Configurazione ZFS server"
f2=$(basename "$0")
f2="${filename%.*}"
f2=$f2.lst


whiptail --title "$TT" --msgbox "Installazione HEADERS LINUX" $NN 

apt -y install linux-headers-$(uname -r)


whiptail --title "$TT" --msgbox "Installazione pacchetti ZFS" $NN

apt  --yes install   $(< $f2 )


whiptail --title "$TT" --msgbox "Configurazione modulo ZFS" $NN

install -b $f1/etc/modprobe.d/zfs.conf /etc/modprobe.d/zfs.conf


whiptail --title "$TT" --msgbox "Configurazione SMB.CONF per condivisione automatica" $NN

cp -b /etc/samba/smb.conf /etc/samba/smb.conf
sed -i '/[global]/i \
    usershare path = /var/lib/samba/usershares\
    usershare max shares = 100\
    usershare allow guests = yes\
    usershare owner only = no' /etc/samba/smb.conf


whiptail --title "$TT" --msgbox "Edit RC.LOCAL\nPer scheduler dischi, suggerito mq-deadline per tutti" $NN


