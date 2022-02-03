#!/bin/bash
#
# Display a user link.
#
set -e

source .env
echo ""
echo "Visit http://0.0.0.0:$DOCKERPORT to see the site locally."
echo "Use ./scripts/reset-password.sh admin to reset your password."
echo ""
echo "See ./README.md for more details."
echo ""
