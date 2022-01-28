#!/bin/bash
#
# Wait for the database to be up
#
set -e

docker-compose exec database /bin/bash -c '/docker-resources/wait-for-database.sh'
