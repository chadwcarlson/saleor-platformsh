#!/usr/bin/env bash

set -e

VERSIONS_FILE=upstreams/versions.json

ls -a $PLATFORM_CACHE_DIR

# Get and configure Poetry.
POETRY_VERSION=$(cat $VERSIONS_FILE | jq -r '.poetry.version')
./scripts/download_poetry.sh $POETRY_VERSION
./scripts/setup_poetry.sh

# Get and configure Saleor.
SALEOR_VERSION=$(cat $VERSIONS_FILE | jq -r '.saleor.version')
./scripts/download_saleor.sh $SALEOR_VERSION
./scripts/setup_saleor.sh
