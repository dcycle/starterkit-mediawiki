#!/bin/bash
#
# Destroy an environment
#
set -e

echo ''
echo '-----'
echo 'NOT Destroying the do-not-commit directory as it may contain backups and we do not want to lose them.'

echo ''
echo '-----'
echo 'Destroying the environment and volumes.'
docker-compose down -v

echo ''
echo '-----'
echo 'Destroying config files.'
rm -f ./.env
rm -f ./LocalSettings.php

echo ''
echo '-----'
echo 'Your environment is completely destroyed.'
echo ''
echo ''
