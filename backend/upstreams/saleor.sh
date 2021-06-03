#!/usr/bin/env bash

VERSIONS_FILE=upstreams/versions.json
UPSTREAM=$(cat $VERSIONS_FILE | jq -r '.saleor.upstream')
VERSION=$(cat $VERSIONS_FILE | jq -r '.saleor.version')
echo -e "\nDownloading Saleor backend (\033[1m$VERSION\033[0m)\n"
wget --quiet -c https://github.com/$UPSTREAM/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz
# Remove existing saleor subdirectory if on local.
if [ -d saleor ]; then
    rm -rf saleor
fi
mv saleor-$VERSION saleor
