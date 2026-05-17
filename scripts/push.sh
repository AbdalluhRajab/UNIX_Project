#!/bin/bash

# Automated Git push script for UNIX_Project
# Usage:
#   bash scripts/push.sh abdallah "commit message"
#   bash scripts/push.sh abdallah2 "commit message"

if [ $# -ne 2 ]; then
    echo "Usage: bash scripts/push.sh <abdallah|abdallah2> \"commit message\""
    exit 1
fi

USER_ACCOUNT="$1"
MESSAGE="$2"

case "$USER_ACCOUNT" in
    abdallah)
        NAME="AbdalluhRajab"
        EMAIL="abdalluh.mahfos2@gmail.com"
        ;;
    abdallah2)
        NAME="abdalluhrajab2-dot"
        EMAIL="abdalluh.rajab2@gmail.com"
        ;;
    *)
        echo "Unknown user. Use: abdallah or abdallah2"
        exit 1
        ;;
esac

BRANCH=$(git branch --show-current)

echo "Using Git identity:"
echo "$NAME <$EMAIL>"

git config user.name "$NAME"
git config user.email "$EMAIL"

echo "Adding files..."
git add -A

echo "Creating commit..."
git commit -m "$MESSAGE"

echo "Pushing to GitHub..."
git push origin "$BRANCH"

echo "Done."