#!/bin/bash
#
# Wait for the database to be up
#
set -e

echo "Will try to connect to the database until it is up. This can take up to 15 seconds if the container has just been spun up."
OUTPUT="ERROR"
TRIES=15
for i in `seq 1 "$TRIES"`;
do
  OUTPUT=$(echo 'show databases'|{ mysql -u wikiuser --password="$MYSQL_PASSWORD" 2>&1 || true; })
  if [[ "$OUTPUT" == *"ERROR"* ]]; then
    if [ "$i" == "$TRIES" ];then
      echo "MySQL container after $TRIES tries, with error $OUTPUT. Abandoning. We suggest you reset Docker to factory defaults, then give Docker 6Gb instead of 2Gb RAM in the Resources section of the preferences pane, and try again. If you are still getting an error please open a ticket at https://github.com/dcycle/starterkit-drupal8site/issues with this message and any other information about your environment."
      exit 1
    else
      echo "Try $i of $TRIES. MySQL container is not available yet. Should not be long..."
      sleep 2
    fi
  else
    echo "MySQL is up! Moving on..."
    break
  fi
done
