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

echo ""
echo "Creating a random backup ID."
ID="$RANDOM"
echo "Random id is $ID."
echo ""

echo ""
echo "Attempting to fetch a backup from an environment."
echo ""
./scripts/remote/get-database-to-local.sh "$ENV" "$ID"

echo ""
echo "Importing the database to local."
echo ""
./scripts/revert-from-backup "$ID"

echo ""
echo "Done importing datase from $ENV to local"
echo ""
