#!/bin/bash

TT="Installazione e Configurazione BIND9"


whiptail --title $TT --msgbox "Installazione pacchetto BIND9" $NN

apt -y install bind9


whiptail --title $TT --msgbox "Impostazione files di configurazione" $NN

cat <<EOF >>/etc/bind/named.conf.local
zone "casabella.local" {
type master;
file "/etc/bind/db.casabella";
};
EOF

cat <<EOF >>/etc/bind/named.conf.options
options {
	directory "/var/cache/bind";
};
EOF

cat <<EOF >>/etc/bind/db.casabella
$TTL 10800
@	IN	SOA	xxxserver.casabella.local. root.xxxserver.casabella.local. (
			2006050657
			10800
			3600
			2419200
			3600 )
;
@ IN NS xxxserver.casabella.local.
;
wlangw	IN A 192.168.1.101
deb1server IN A 192.168.1.101
deb2server IN A 192.168.1.102
deb3server IN A 192.168.1.103
deb4server IN A 192.168.1.104
deb5server IN A 192.168.1.105
deb6server IN A 192.168.1.106
debpopi IN A 192.168.1.3
debmultimedia IN A 192.168.1.128
router IN A 192.168.1.254
ns0046 IN A 192.168.1.193
;
vim0.casabella.local.	IN	CNAME	deb1server.casabella.local.
vim1.casabella.local.	IN	CNAME	deb1server.casabella.local.
popadeb.casabella.local.	IN	A	192.168.1.129
pumawiki.casabella.local.	IN	CNAME	deb1server.casabella.local.
EOF



whiptail --title $TT --msgbox "Fine script\n\nEditare NAMED.CONF.LOCAL e db.casabella\nin funzione della installazione specifica" $NN

vi /etc/bind/named.conf.local /etc/bind/db.casabella 

