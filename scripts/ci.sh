#!/bin/bash
#
# Continuous integration script run on CircleCI, see ./.circleci/config.yml.
#
set -e

echo ""
echo "Deploying the site"
echo ""
./scripts/deploy.sh
echo ""
echo "Test the running environment"
echo ""
./scripts/test-running-environment.sh
echo ""
echo "Destroying the environment"
echo ""
./scripts/destroy.sh
echo ""
echo "Good job, all tests are passing!"
echo ""
