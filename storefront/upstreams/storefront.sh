#!/usr/bin/env bash

set -e
# VERSIONS_FILE=upstreams/versions.json
# UPSTREAM=$(cat $VERSIONS_FILE | jq -r '.storefront.upstream')
# VERSION=$(cat $VERSIONS_FILE | jq -r '.storefront.version')
# echo -e "\nDownloading Saleor storefront (\033[1m$VERSION\033[0m)\n"
# wget --quiet -c https://github.com/$UPSTREAM/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz
# # Remove existing saleor subdirectory if on local.
# if [ -d saleor-storefront ]; then
#     rm -rf saleor-storefront
# fi
# mv saleor-storefront-$VERSION saleor-storefront

cd saleor-storefront
npm install

# export API_URI=https://api.master-7rqtwti-pm723toxitfuq.us-4.platformsh.site/graphql/
# npm run build