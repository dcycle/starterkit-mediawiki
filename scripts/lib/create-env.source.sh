# This file is meant to be sourced.
#
# Make sure we can run a docker-compose command.
#
set -e

ENVFILELOCATION=./.env
if [ -f "$ENVFILELOCATION" ]; then
  >&2 echo "Cannot call ./scripts/create-env.source.sh if $ENVFILELOCATION exists."
  exit 1
fi
{
  echo "MYSQL_PASSWORD=$(./scripts/uuid.sh)"
  echo "WIKI_SALT=$(./scripts/uuid.sh)"
}  >> "$ENVFILELOCATION"
