#!/usr/bin/env bash

set -e
VERSIONS_FILE=upstreams/versions.json
UPSTREAM=$(cat $VERSIONS_FILE | jq -r '.dashboard.upstream')
VERSION=$(cat $VERSIONS_FILE | jq -r '.dashboard.version')
echo -e "\nDownloading Saleor dashboard (\033[1m$VERSION\033[0m)\n"
wget --quiet -c https://github.com/$UPSTREAM/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz
# Remove existing saleor subdirectory if on local.
if [ -d saleor-dashboard ]; then
    rm -rf saleor-dashboard
fi
mv saleor-dashboard-$VERSION saleor-dashboard
