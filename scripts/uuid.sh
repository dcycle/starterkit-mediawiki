#!/bin/bash
#
# Generate a UUID.
#
set -e

docker run --rm mediawiki /bin/bash -c 'cat /proc/sys/kernel/random/uuid'
