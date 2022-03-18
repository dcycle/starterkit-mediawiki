#!/bin/bash
#
# Get the database from production to local.
#
set -e

echo ""
echo "Preflight"
echo ""
BASEDIR=./scripts/remote/environments/
if [ -z "$1" ]; then
  >&2 echo "Please pass one of these arguments:"
  ls "$BASEDIR" | xargs -n1 echo
  exit 1
fi
ENV="$1"
ENVDIR="$BASEDIR$ENV"
ENVDIR="$BASEDIR$ENV"
ENVFILE="$ENVDIR/info.source.sh"
if [ ! -f "$ENVFILE" ]; then
  >&2 echo "$ENVFILE was not found."
  >&2 echo "Please make sure you pass one of the following arguments:"
  ls "$BASEDIR" | xargs -n1 echo
  exit 1
fi
if [ -z "$1" ]; then
  >&2 echo "Please pass one of these arguments:"
  ls "$BASEDIR" | xargs -n1 echo
  exit 1
fi
if [ -z "$2" ]; then
  >&2 echo "Please pass an ID, can be a random number such as 12345:"
  exit 1
fi
ID="$2"

source $ENVFILE
echo ""
echo "Will try to create a backup of the $ENV environment."
echo ""

ssh "$USER"@"$IP" "cd $LOC && ./scripts/make-backup.sh $ID"

echo ""
echo "Will copy the backup to the local installation."
echo ""

mkdir -p ./do-not-commit/backups
scp -r "$USER"@"$IP": "$LOC/do-not-commit/backups/$ID" ./do-not-commit/backups/

echo ""
echo "Done getting database from remote $ENV"
echo ""
