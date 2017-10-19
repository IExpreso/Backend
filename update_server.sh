#!/bin/sh
git remote -v update
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up to date";
elif [ $LOCAL = $BASE ]; then
    fuser -k 3000/tcp > /dev/null;
    git pull;
    npm install;
    npm start &;
    echo "Server restarted";
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi
