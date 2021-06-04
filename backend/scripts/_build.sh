#!/usr/bin/env bash

set -e

VERSIONS_FILE=upstreams/versions.json

# Get and configure Poetry.
POETRY_VERSION=$(cat $VERSIONS_FILE | jq -r '.poetry.version')
./scripts/download_poetry.sh $POETRY_VERSION

# Get and configure Saleor.
SALEOR_VERSION=$(cat $VERSIONS_FILE | jq -r '.saleor.version')
./scripts/download_saleor.sh
./scripts/setup_saleor.sh
