#!/bin/bash
# pull.sh - Pulls the latest code from GitHub.
# Used by Jenkins (or manually) to fetch the newest version of the project
# before building and deploying.

set -e

REPO_URL="https://github.com/AbdalluhRajab/UNIX_Project.git"
BRANCH="main"
TARGET_DIR="${1:-.}"

echo "Pulling latest code from $REPO_URL ($BRANCH) into $TARGET_DIR"

if [ -d "$TARGET_DIR/.git" ]; then
    echo "Existing repo found. Fetching and resetting to origin/$BRANCH..."
    cd "$TARGET_DIR"
    git fetch origin "$BRANCH"
    git reset --hard "origin/$BRANCH"
    git clean -fd
else
    echo "No git repo here. Cloning fresh..."
    rm -rf "$TARGET_DIR"
    git clone --branch "$BRANCH" "$REPO_URL" "$TARGET_DIR"
fi

echo "Pull complete. Current commit:"
cd "$TARGET_DIR" && git log -1 --oneline
