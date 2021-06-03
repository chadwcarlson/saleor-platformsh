#!/usr/bin/env bash

VERSIONS_FILE=upstreams/versions.json
UPSTREAM=$(cat $VERSIONS_FILE | jq -r '.poetry.upstream')
VERSION=$(cat $VERSIONS_FILE | jq -r '.poetry.version')

curl -s https://raw.githubusercontent.com/$UPSTREAM/master/get-poetry.py >> get-poetry.py
python get-poetry.py --version $VERSION
rm get-poetry.py
