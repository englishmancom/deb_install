k3#! /bin/bash

PRIORITY=$1
MACHINE=`uname -n`
CUSTOMER='1807SNC'
MAIL_USER='tech@1807snc.it'
MAIL_SUBJ="From $MACHINE priority $PRIORITY events"
F="/var/log/check_journal_$1"
DATE=`date +"%F %X"`
DATE2=`ls --time-style  long-iso -l $F | awk '{print $6 " " $7}' `

journalctl -p $PRIORITY --since="$DATE2" | grep -v "No entries" |grep -v "Journal begins" |grep -v "Logs begin at" >$F
touch -d"$DATE" $F

if [ -s $F ]
then

printf "$MAIL_SUBJ \n\n $F" | ssmtp $MAIL_USER

fi

