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
  echo "SETTING MYID TO $MYID"
fi

echo "...Figuring out where to put the backup."
MYDIR="./do-not-commit/backups/$MYID"
MYCONTAINERDIR="/do-not-commit/backups/$MYID"
rm -rf "$MYDIR"
echo "   ID: $MYID"
echo "   Dir on host: $MYDIR"
echo "   Dir on container: $MYCONTAINERDIR"
docker-compose exec -T database /bin/bash -c "mkdir -p $MYCONTAINERDIR"
source ./.env
echo "...Generating backup.sql, **this can take several minutes**"
docker-compose exec -T database /bin/bash -c "export MYSQL_PWD=$MYSQL_PASSWORD; mysqldump -u wikiuser my_wiki > $MYCONTAINERDIR/backup.sql"

echo "...Exporting files**"
docker-compose exec -T mediawiki /bin/bash -c "cp -r /var/www/html/images $MYCONTAINERDIR/images"

echo "...Backup created in $MYDIR"
