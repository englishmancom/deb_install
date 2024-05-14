#!/bin/bash
#-----------------------------------------
# backup con rdiff-backup per directory sviluppo e mysql
#--------------------------------------------
MACHINE=`uname -n`
MAIL_SUBJ="From $MACHINE at 1807snc daily local backups"
MAIL_USER="tech@1807snc.it"

rdiff-backup /var/lib/dpkg /backup/root/dpkg
rdiff-backup /etc /backup/root/etc
#data=`date +%Y%m%d%H%M%S`
#mysqldump -uroot -proot --all-databases |gzip >/backup/mysql/mysql_full_$data.dmp.gz

printf "$MAIL_SUBJ \n\n Backup locale giornaliero effettuato\n" | ssmtp $MAIL_USER
