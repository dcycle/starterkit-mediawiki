#!/bin/bash
#
# Deploy an environment
#
set -e

echo ''
echo '-----'
echo 'Ensuring the integrity of the .env file.'
source ./scripts/lib/assert-env.source.sh

echo ''
echo '-----'
echo 'Pulling the latest docker images that we need.'
docker pull mariadb
docker pull mediawiki

echo ''
echo '-----'
echo 'Starting the environment.'
if [[ -f LocalSettings.php ]]; then
  echo '(LocalSettings.php exists, just updating the installation with existing details.)'
  docker-compose -f docker-compose.yml -f docker-compose.local-settings-exists.yml up -d
else
  echo '(LocalSettings.php does not exist, performing initial set up.)'
  docker-compose up -d
fi

if [[ -f LocalSettings.php ]]; then
  echo ''
  echo '-----'
  echo 'Getting the login details.'
  ./scripts/uli.sh
else
  echo ''
  echo '-----'
  source ./scripts/lib/initial-setup-instructions.source.sh
fi
