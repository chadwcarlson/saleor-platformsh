#!/usr/bin/env bash

# Get and configure Poetry.
./scripts/download_poetry.sh
./scripts/configure_poetry.sh

# Get and configure Saleor.
./scripts/download_saleor.sh
./scripts/setup_saleor.sh
