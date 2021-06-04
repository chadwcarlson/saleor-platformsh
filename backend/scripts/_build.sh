#!/usr/bin/env bash

./scripts/_aline.sh START "build"

# Get and configure Poetry.
./scripts/download_poetry.sh
./scripts/setup_poetry.sh

# Get and configure Saleor.
./scripts/download_saleor.sh
./scripts/setup_saleor.sh

./scripts/_aline.sh END "build"
