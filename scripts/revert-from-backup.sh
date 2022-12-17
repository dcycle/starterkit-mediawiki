#!/bin/bash
#
# Creates a backup.
#
set -e

echo "About to try to revert from a backup."
BACKUPDIR=./do-not-commit/backups
echo "Available backups in $BACKUPDIR are:"
ls "$BACKUPDIR"

if [ -z "$1" ]; then
  >&2 echo "Please choose one of the above backups, if possible."
  exit 1
fi

ID="$1"
CANDIDATE="$BACKUPDIR/$ID"

if [ ! -d "$CANDIDATE" ]; then
  >&2 echo "The directory your specified, $CANDIDATE, does not exist."
  exit 1
else
  echo "$CANDIDATE is a directory, about to check if it is valid."
fi

if [ ! -f "$CANDIDATE/backup.sql" ]; then
  >&2 echo "$CANDIDATE/backup.sql does not exist; please make sure the directory is valid."
  exit 1
fi

if [ ! -d "$CANDIDATE/images" ]; then
  >&2 echo "$CANDIDATE/images does not exist or is not a directory; please make sure the directory is valid."
  exit 1
fi

./scripts/make-backup.sh
source ./.env
docker-compose exec database /bin/bash -c "mysql --password=$MYSQL_PASSWORD -u wikiuser -e 'DROP DATABASE my_wiki;' && mysql --password=$MYSQL_PASSWORD -u wikiuser -e 'CREATE DATABASE my_wiki;' && mysql --password=$MYSQL_PASSWORD -u wikiuser my_wiki < /do-not-commit/backups/$ID/backup.sql"
docker-compose exec mediawiki /bin/bash -c "cp -r /do-not-commit/backups/$ID/images/* /var/www/html/images/"

./scripts/deploy.sh

echo "Backup $ID imported."
