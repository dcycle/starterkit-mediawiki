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

PW_RESET_SUCCESS=1
docker-compose exec mediawiki /bin/bash -c "cd maintenance && php changePassword.php --user=$1 --password=$NEWPW" || PW_RESET_SUCCESS=0

if [ "$PW_RESET_SUCCESS" == 1 ]; then
  echo ""
  echo "New credentials:"
  echo ""
  echo "    username: $1"
  echo "    password: $NEWPW"
  echo ""
else
  echo ""
  echo "Could not set the password for the user $1 because that user does not"
  echo "seem to exist, or another error occurred. This might be the case if,"
  echo "for example, you are using the default ./scripts/deploy.sh script and"
  echo "your user is not admin."
  echo ""
  echo "If you need to reset your user's password, figure out the name of an"
  echo "existing user, then call ./scripts/reset-password.sh USER_THAT_EXISTS"
  echo ""
  echo "Moving on without failing..."
  echo ""
fi
