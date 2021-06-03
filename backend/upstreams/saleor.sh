#!/usr/bin/env bash

VERSIONS_FILE=upstreams/versions.json
UPSTREAM=$(cat $VERSIONS_FILE | jq -r '.saleor.upstream')
VERSION=$(cat $VERSIONS_FILE | jq -r '.saleor.version')

wget --quiet -c https://github.com/$UPSTREAM/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz
if [ -d saleor ]; then
    rm -rf saleor
fi
mv saleor-$VERSION saleor
