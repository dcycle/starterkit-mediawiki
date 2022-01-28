#!/bin/bash
#
# Creates a backup.
#
set -e

if [ -z "$1" ]; then
  MYID="$RANDOM"
  echo "SETTING MYID TO RAND $MYID"
else
  MYID="$1"
  echo "SETTING MYID TO 1 $MYID"
fi

MYDIR="./do-not-commit/backups/$MYID"
MYCONTAINERDIR="/do-not-commit/backups/$MYID"
rm -rf "$MYDIR"
docker-compose exec database /bin/bash -c "mkdir -p $MYCONTAINERDIR"
source ./.env
docker-compose exec database /bin/bash -c "export MYSQL_PWD=$MYSQL_PASSWORD; mysqldump -u wikiuser my_wiki > $MYCONTAINERDIR/backup.sql"

docker-compose exec mediawiki /bin/bash -c "cp -r /var/www/html/images $MYCONTAINERDIR/images"

echo "Backup created in $MYDIR"
