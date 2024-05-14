#!/bin/bash

apt -y install whiptail


filename="./sysconf.d"

TT="Configurazione di sistema 1"


whiptail --title "$TT" --msgbox "Configurazione APT" $NN

install -b $filename/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d
install -b $filename/etc/apt/sources.list /etc/apt/sources.list


whiptail --title "$TT" --msgbox "Configurazione MODPROBE" $NN

install -b $filename/etc/modprobe.d/* /etc/modprobe.d


whiptail --title "$TT" --msgbox "Configurazione INITRAMFS e GRUB" $NN

install -b $filename/etc/initramfs-tools/modules /etc/initramfstools
install -b $filename/etc/default/grub /etc/default


whiptail --title "$TT" --msgbox "Configurazione FSTAB" $NN

cat <<EOF >>/etc/fstab
#esempio di partizione ext4 hdd - per SSD non aggoungere discard ma creare crontab
#   noatime,commit=600,nobarrier
#/swapfile none            swap    sw              0       0
#esempio di disco samba
#//xxserverxx/xxdirxx	/home/xxuserxx/xxsubdirxx	cifs	username=xxuserxx,password=xxuid,uid=xxuidxx,gid=xxgidxx,domain=xxdomainxx	0	0
EOF


whiptail --title "$TT" --msgbox "Configurazione RC.LOCAL" $NN

cat <<EOF >>/etc/rc.local
# none oppure mq-deadline 
#echo mq-deadline >/sys/block/sda/queue/scheduler
#echo mq-deadline >/sys/block/sdb/queue/scheduler
#echo lz4 > /sys/module/zswap/parameters/compressor
#echo z3fold > /sys/module/zswap/parameters/zpool
EOF

chmod 755 /etc/rc.local


whiptail --title "$TT" --msgbox "Configurazione SYSCTL.CONF" $NN

cat <<EOF >>/etc/sysctl.conf
# IPv6 disabled
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

whiptail --title "$TT" --msgbox "Configurazione CRONTAB di ROOT" $NN 

cat <<EOF >>/var/spool/cron/crontabs/root
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SHELL=/bin/bash
# per effettuare il trim settimanalmente sugli FS dei SSD e sulla partizione SWAP su SSD.
# fa tutto automaticamente con il -a
@weekly fstrim -a
50 23 * * * ./status.sh
@hourly /root/check_journal.sh 2
@hourly /root/check_journal.sh 4
#0 1 * * sun /root/check_disks.sh
#0 23 * * sun /root/check_arrays.sh
50 22 * * * /root/local-backups.sh
#50 23 * * * /root/remote-backups.sh
EOF


whiptail --title "$TT" --msgbox "Copia procedure manutenzione in ROOT" $NN

install -b $filename/root/*sh /root
chmod 755 /root/*sh

install -b $filename/root/bashrc /root.bashrc
install -b $filename/root/dircolors /root/.dircolors


whiptail --title "$TT" --msgbox "Editare manualmente rc.local , sysctl.conf , e fstab" $NN

vi /etc/rc.local /etc/sysctl.conf /etc/fstab


whiptail --title "$TT" --msgbox "UPDATE di INITRAMFS" $NN

update-initramfs -k all -u


whiptail --title "$TT" --msgbox "UPDATE di GRUB" $NN

update-grub


whiptail --title "$TT" --msgbox "Creazione e attivazione SWAPFILE" $NN

fallocate -l 1G /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=1024
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cat <<EOF >>/etc/fstab
/swapfile	swap	swap	defaults	0	0
EOF


whiptail --title "$TT" --msgbox "FINE dello script\nEseguire REBOOT" $NN
