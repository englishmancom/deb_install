#! /bin/bash
#export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin
for i in /dev/sd?
do
#	smartctl -t long $i
	nohup badblocks -b4096  $i &
	hdparm -S 241 $i
done
