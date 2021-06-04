#!/usr/bin/env bash

./scripts/_aline.sh START "Download Saleor"

VERSION=$1
echo -e "\nDownloading Saleor backend (\033[1m$VERSION\033[0m)\n"
wget --quiet -c https://github.com/mirumee/saleor/archive/refs/tags/$VERSION.tar.gz -O - | tar -xz
# Remove existing saleor subdirectory if on local.
if [ -d saleor ]; then
    rm -rf saleor
fi
mv saleor-$VERSION saleor

CURRENT_VERSION=$(cat saleor/package.json | jq -r '.version')
echo -e "Finished. Saleor version $CURRENT_VERSION\n"

./scripts/_aline.sh END "Download Saleor"
