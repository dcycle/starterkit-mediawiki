#!/bin/bash
#
# Continuous integration script run on CircleCI, see ./.circleci/config.yml.
#
set -e

echo ""
echo "Lint code"
echo ""
./scripts/lint.sh
echo ""
echo "Deploying the site"
echo ""
./scripts/deploy.sh
echo ""
echo "Test the running environment"
echo ""
./scripts/test-running-environment.sh
echo ""
echo "Make a backup"
echo ""
./scripts/make-backup.sh ci-backup
echo ""
echo "Revert from backup"
echo ""
./scripts/revert-from-backup.sh ci-backup
echo ""
echo "Test the running environment, again, with the reverted backup"
echo ""
./scripts/test-running-environment.sh
echo ""
echo "Destroying the environment"
echo ""
./scripts/destroy.sh
echo ""
echo "Good job, all tests are passing!"
echo ""
