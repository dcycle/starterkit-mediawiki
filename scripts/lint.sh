#!/bin/bash
#
# Lint the code.
#
set -e

docker run --rm -v "$(pwd)":/app/code dcycle/json-lint:2 \
    ./code/mediawiki/CustomExtension/extension.json
