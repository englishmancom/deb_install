#!/bin/bash
set -x
data=`date +%Y%m%d%H%M%S`
tar -z --create --file=/backup/www/$1_$data.inc.tar.gz --listed-incremental=/var/log/tar/$1 /var/www/$1 >/tmp/$1_$data.inc.log
rsync -ae ssh /backup/www/ popi@bsd3server:/tutto/backup/deb4server/www
