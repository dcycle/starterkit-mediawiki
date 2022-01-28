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
docker-compose up -d --build
if [[ -f LocalSettings.php ]]; then
  echo '(LocalSettings.php exists, just updating the installation with existing details.)'
  docker cp LocalSettings.php $(docker-compose ps -q mediawiki):/var/www/html/LocalSettings.php
else
  echo '(LocalSettings.php does not exist, performing initial set up.)'
  docker-compose up -d
fi

if [[ ! -f ./LocalSettings.php ]]; then
  echo ''
  echo '-----'
  echo 'Importing starter data...'
  ./scripts/wait-for-database.sh
  cp ./starter-data/LocalSettings.example.php ./LocalSettings.php
  docker-compose exec mediawiki /bin/bash -c '/docker-resources/import-starter-data.sh'
  rm -rf ./do-not-commit/backups/starter
  docker-compose exec mediawiki /bin/bash -c 'mkdir -p /do-not-commit/backups'
  docker-compose exec mediawiki /bin/bash -c 'cp -r /starter-data/data /do-not-commit/backups/starter'
  ./scripts/revert-from-backup.sh starter
  docker-compose exec mediawiki /bin/bash -c 'rm -rf /do-not-commit/backups/starter'
  echo 'Redeploying...'
  ./scripts/deploy.sh
else
  echo ''
  echo '-----'
  echo 'Resetting admin password.'
  ./scripts/reset-password.sh admin
  echo ''
  echo '-----'
  echo 'Getting the login details.'
  ./scripts/uli.sh
fi
