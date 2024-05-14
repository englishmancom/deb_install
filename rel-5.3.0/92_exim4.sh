#!/bin/bash

TT="Installazione mailer EXIM4"

whiptail --title "$TT" --msgbox "Installazione pacchetto EXIM4 e collegati" $NN

apt --yes install exim4 bsd-mailx


whiptail --title "$TT" --msgbox "Creazione configurazione EXIM4" $NN

cat <<EOF >>/etc/exim4/passwd.client
*.google.com:tech@1807snc.it:geox01
EOF

cat <<EOF >>/etc/exim4/update-exim4.conf.conf
dc_eximconfig_configtype='satellite'
dc_other_hostnames='xxx.casabella.local'
dc_local_interfaces='127.0.0.1'
dc_readhost='xxx.casabella.local'
dc_relay_domains=''
dc_minimaldns='false'
dc_relay_nets=''
dc_smarthost='smtp.gmail.com::587'
CFILEMODE='644'
dc_use_split_config='true'
dc_hide_mailname='true'
dc_mailname_in_oh='true'
dc_localdelivery='mail_spool'
EOF

cat <<EOF >>/etc/aliases
mailer-daemon: tech@1807snc.it
postmaster: tech@1807snc.it
nobody: tech@1807snc.it
hostmaster: tech@1807snc.it
usenet: tech@1807snc.it
news: tech@1807snc.it
webmaster: tech@1807snc.it
www: tech@1807snc.it
ftp: tech@1807snc.it
abuse: tech@1807snc.it
noc: tech@1807snc.it
security: tech@1807snc.it
root: tech@1807snc.it
popi: tech@1807snc.it
EOF


whiptail --title "$TT" --msgbox "Update configurazione EXIM4" $NN

update-exim4.conf


whiptail --title "$TT" --msgbox "Restart servizio EXIM4" $NN

systemctl restart exim4
