#!/bin/bash
data=`date +%Y%m%d%H%M%S`
tar -z --level=0 --listed-incremental=/var/log/tar/$1 --create --file=/backup/www/$1_$data.full.tar.gz /var/www/$1 >/tmp/$1_$data.full.log
rsync -ae ssh /backup/www/ popi@bsd3server:/tutto/backup/deb4server/www
