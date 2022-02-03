#
# Make sure we can run a docker-compose command.
#
set -e

source config/versioned
if [ ! -f ./.env ]; then
  source ./scripts/lib/create-env.source.sh
fi
grep 'DOCKERPORT' .env >/dev/null || echo "DOCKERPORT=$DOCKERPORT" >> .env
source ./.env
