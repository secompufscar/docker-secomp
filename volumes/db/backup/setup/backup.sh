#!/bin/sh

BACKUP_FOLDER=/opt/mysql/backup
NOW=$(date '+%d')

GZIP=$(which gzip)
MYSQLDUMP=$(which mysqldump)

### MySQL Server Login info ###
MDB=$MYSQL_DATABASE
MHOST=db
MPASS=$MYSQL_ROOT_PASSWORD
MUSER=root

[ ! -d $BACKUP_FOLDER ] && mkdir --parents $BACKUP_FOLDER

FILE=$BACKUP_FOLDER/backup-$NOW.sql.gz
$MYSQLDUMP -h $MHOST -u $MUSER -p$MPASS --databases $MDB | $GZIP -9 > $FILE
