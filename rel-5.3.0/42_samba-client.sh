#!/bin/bash

TT="Installazione di SAMBA client per desktop"
FROM=./sysconf.d/home
TO="/home/$UTENTE"
filename=$(basename "$0")
filename="${filename%.*}"


whiptail --title "$TT" --msgbox "Installazione pacchetti" $NN

apt   --yes install   $(< $filename.lst )


whiptail --title "$TT" --msgbox "Modifica FSTAB" $NN

cat <<EOF >>/etc/fstab
# disco samba
//deb1server/1807	/home/popi/media/1807	cifs	user,username=popi,password=geox01	0	0
EOF


whiptail --title "$TT" --msgbox "Installazione script per MOUNT e UNMOUNT" $NN

mkdir -p $TO/media/1807
chown $UTENTE:$UTENTE $TO/media/1807

mkdir -p $TO/.local/bin
install -b -D -g$UTENTE -o$UTENTE $FROM/local/bin/cifs-mount		$TO/.local/bin
ln -s $TO/.local/bin/cifs-mount $TO/.local/bin/cifs-umount
chown $UTENTE:$UTENTE $TO/.local/bin/cifs-umount
read



