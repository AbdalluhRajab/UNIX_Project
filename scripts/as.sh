#!/bin/bash

# Switch git identity for the next commits
# Usage:
#   bash scripts/as.sh abdalluh
#   bash scripts/as.sh abdalluh2

case "$1" in
    abdalluh)
        git config user.name "AbdalluhRajab"
        git config user.email "abdalluh.mahfos2@gmail.com"
        ;;

    abdalluh2)
        git config user.name "abdalluhrajab2-dot"
        git config user.email "abdalluh.rajab2@gmail.com"
        ;;

    *)
        echo "Usage: $0 <abdalluh|abdalluh2>"
        exit 1
        ;;
esac

echo " Now committing as: $(git config user.name) <$(git config user.email)>"