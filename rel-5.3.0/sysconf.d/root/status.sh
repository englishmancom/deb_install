#!/bin/bash

#export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin

MACHINE=`uname -n`
CUSTOMER='1807SNC'
TESTO='/tmp/testo.txt'
MAIL_SUBJ="From $MACHINE at 1807snc daily report"
MAIL_USER="tech@1807snc.it"
SEP="-----------------------------------------------------------------"
SEP2="================================================================="

echo '' >$TESTO
#--------------------------------------------------------------
#Intestazione
#---------------------------------------------------------------
echo $SEP2 >>$TESTO
echo $CUSTOMER >>$TESTO
echo $MACHINE >>$TESTO
echo `date` >>$TESTO
echo $SEP2 >>$TESTO
#--------------------------------------------------------------
#Sensori HW
#---------------------------------------------------------------
echo 'Sensori HW:' >> $TESTO
sensors >>$TESTO
echo $SEP >>$TESTO
cpufreq-info -s -m >>$TESTO
echo $SEP2 >>$TESTO
#--------------------------------------------------------------
#devices raid
#---------------------------------------------------------------
#cat /proc/mdstat >>$TESTO
#--------------------------------------------------------------
# status zpool
#---------------------------------------------------------------
zpool status >>$TESTO
echo $SEP >>$TESTO
zfs list >>$TESTO
echo $SEP2 >>$TESTO
#--------------------------------------------------------------
#devices drbd
#---------------------------------------------------------------
#--------------------------------------------------------------
#fsck a caldo
#---------------------------------------------------------------
#--------------------------------------------------------------
#df -h
#---------------------------------------------------------------
df -h >>$TESTO
echo $SEP2 >>$TESTO
#------------------------------------------
# backup
#-------------------------------------------
#find /backup/local -name current_mirror* -print >>$TESTO
#echo $SEP >>$TESTO
#du -sh /backup/* >>$TESTO
#echo $SEP2 >>$TESTO
#----------------------------------------------------------------
#dischi
#----------------------------------------------------------------
#for i in /dev/sd?
#do
#	echo $i >>$TESTO
#	echo $SEP >>$TESTO
#	smartctl -A -l error -l selftest $i >>$TESTO
#	echo $SEP >>$TESTO
#done
#echo $SEP2 >>$TESTO
#--------------------------------------------------------------
#send mail
#---------------------------------------------------------------
# echo -e "Subject:" $MAIL_SUBJ "\n" | cat - $TESTO | ssmtp $MAIL_USER 
printf "$MAIL_SUBJ \n\n " | cat - $TESTO | ssmtp $MAIL_USER
