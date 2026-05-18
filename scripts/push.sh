#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: bash scripts/push.sh \"commit message\""
    exit 1
fi

MESSAGE="$1"

echo "Current Git user:"
git config user.name
git config user.email

echo "Pulling latest changes from main..."
git pull origin main

echo "Adding changed files..."
git add -A

echo "Creating commit..."
git commit -m "$MESSAGE"

echo "Pushing to GitHub..."
git push origin main

echo "Done"