#!/bin/bash
#
# setup the image; see Dockerfile.
#
set -e

cp /docker-resources/load-extensions.php /load-extensions.php

# We are ignoring deprecation warnings because some extensions such as
# EmbedVideo have them, and we're not in a position to fix them.
apt-get update
apt-get --no-install-recommends -y install unzip
rm -rf /var/lib/apt/lists/*
echo "display_errors = Off" >> /usr/local/etc/php/php.ini
echo "log_errors = On" >> /usr/local/etc/php/php.ini
echo "error_log = /do-not-commit/php-log.log" >> /usr/local/etc/php/php.ini

/docker-resources/load-extensions.sh
