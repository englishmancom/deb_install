#!/bin/bash
#-----------------------------------------
# rsync della /backup locale con la /backup remota
#--------------------------------------------
MACHINE=`uname -n`
MAIL_SUBJ="From $MACHINE at 1807snc daily remote backups"
MAIL_USER="tech@1807snc.it"

rsync -a /backup/* root@deb5server:/backup/remoti/deb1server

printf "$MAIL_SUBJ \n\n Backup remoto giornaliero effettuato\n" | ssmtp $MAIL_USER

