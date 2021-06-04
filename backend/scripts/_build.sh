#!/usr/bin/env bash

me=`basename "$0"`
./scripts/_aline.sh START $me

# Get and configure Poetry.
./scripts/download_poetry.sh
./scripts/setup_poetry.sh

# Get and configure Saleor.
./scripts/download_saleor.sh
./scripts/setup_saleor.sh

./scripts/_aline.sh END $me
