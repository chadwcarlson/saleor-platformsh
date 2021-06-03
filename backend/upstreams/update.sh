#!/usr/bin/env bash
set -e

UPSTREAM=$1

CURRENT_VERSION=$(cat upstreams/versions.json | jq -r --arg UPSTREAM "$UPSTREAM" '.[$UPSTREAM].version')
NAMESPACE=$(cat upstreams/versions.json | jq -r --arg UPSTREAM "$UPSTREAM" '.[$UPSTREAM].upstream')
RELEASE_URL=https://api.github.com/repos/$NAMESPACE/releases/latest
LATEST_VERSION=$(curl -s $RELEASE_URL| jq -r '.tag_name') 
echo -e "\nRunning scheduled upstream update for \033[1m$UPSTREAM\033[0m.\n"
if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo -e "Current version (\033[1m$CURRENT_VERSION\033[0m) is still the latest.\nSkipping update.\n"
else
    echo -e "An update is available for \033[1m$UPSTREAM\033[0m.\n\n    * \033[1mLatest:\033[0m  $LATEST_VERSION\n    * \033[1mCurrent:\033[0m $CURRENT_VERSION\n"
    python upstreams/bump.py $UPSTREAM $LATEST_VERSION
    git add .
    STAGED_UPDATES=$(git diff --cached)
    NEW_CURRENT_VERSION=$(cat upstreams/versions.json | jq -r --arg UPSTREAM "$UPSTREAM" '.[$UPSTREAM].version')
    if [ ${#STAGED_UPDATES} -gt 0 ] && [ "$NEW_CURRENT_VERSION" = "$LATEST_VERSION" ]; then
        echo -e "Upstream tag updated to $LATEST_VERSION. Committing changes.\n"
        git commit -m "Updated $UPSTREAM ($CURRENT_VERSION -> $LATEST_VERSION)."
    else
        echo -e "No update commits for $UPSTREAM according to \033[1mallowed\033[0m update rules in 'upstreams/versions.json'.\n"
    fi
fi
