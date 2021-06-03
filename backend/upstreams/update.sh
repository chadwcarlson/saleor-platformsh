#!/usr/bin/env bash
set -e

UPSTREAM=$1

CURRENT_VERSION=$(cat upstreams/versions.json | jq -r --arg UPSTREAM "$UPSTREAM" '.[$UPSTREAM].version')
NAMESPACE=$(cat upstreams/versions.json | jq -r --arg UPSTREAM "$UPSTREAM" '.[$UPSTREAM].upstream')
RELEASE_URL=https://api.github.com/repos/$NAMESPACE/releases/latest
LATEST_VERSION=$(curl -s $RELEASE_URL| jq -r '.tag_name') 

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo -e "\n\033[1m$UPSTREAM\033[0m: Current version (\033[1m$CURRENT_VERSION\033[0m) is still the latest.\nSkipping update.\n"
else
    echo -e "\nAn update is available for \033[1m$UPSTREAM\033[0m.\n\n    * \033[1mLatest:\033[0m  $LATEST_VERSION\n    * \033[1mCurrent:\033[0m $CURRENT_VERSION\n"
    python upstreams/bump.py $UPSTREAM $LATEST_VERSION
    git add .
    STAGED_UPDATES=$(git diff --cached)
    if [ ${#STAGED_UPDATES} -gt 0 ]; then
        # echo -e "Configuration updated. Committing.\n"
        git commit -m "Updated $UPSTREAM ($CURRENT_VERSION -> $LATEST_VERSION)."
    else
        echo "No WordPress updates found."
    fi
fi