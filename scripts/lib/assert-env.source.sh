#
# Make sure we can run a docker-compose command.
#
set -e

if [ ! -f ./.env ]; then
  source ./scripts/lib/create-env.source.sh
fi
source ./.env
