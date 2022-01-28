#!/bin/bash
#
# Updates starter data from environment.
#
set -e

MYRAND="$RANDOM"
./scripts/make-backup.sh "$MYRAND"
rm -rf ./starter-data/data
mv ./do-not-commit/backups/"$MYRAND" ./starter-data/data
