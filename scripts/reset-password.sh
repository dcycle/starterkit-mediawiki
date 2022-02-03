#!/bin/bash
#
# Reset a password.
#
set -e

source .env
if [[ -z "$1" ]]; then
  >&2 echo "Please specify a username."
  exit 1;
fi

NEWPW=$(./scripts/uuid.sh)

# See https://www.mediawiki.org/wiki/Manual:ChangePassword.php.

echo ""
echo "Will attempt to change the password for user $1:"
echo "If this does not work, visit http://0.0.0.0:$DOCKERPORT/api.php?action=query&format=json&list=allusers"
echo "if you forgot your username."

docker-compose exec mediawiki /bin/bash -c "cd maintenance && php changePassword.php --user=$1 --password=$NEWPW"

echo ""
echo "New credentials:"
echo ""
echo "    username: $1"
echo "    password: $NEWPW"
echo ""
