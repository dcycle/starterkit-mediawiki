#!/bin/bash
#
# Destroy an environment
#
set -e

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
echo 'Destroying the do-not-commit directory.'
rm -rf ./do-not-commit

echo ''
echo '-----'
echo 'Your environment is completely destroyed.'
echo ''
echo ''
