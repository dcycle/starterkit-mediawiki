#!/bin/bash
#
# Test the running environment.
#
set -e

curl -L "http://$(docker-compose port mediawiki 80)"|grep "Main page"
