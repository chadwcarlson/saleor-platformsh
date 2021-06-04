#!/usr/bin/env bash

./scripts/_aline.sh START "Download Poetry"

VERSION=$1
echo -e "\nDownloading Poetry (\033[1m$VERSION\033[0m)\n"
curl -s https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py >> get-poetry.py
python get-poetry.py --version $VERSION
rm get-poetry.py

# Configure Poetry.
./scripts/setup_poetry.sh
. ./scripts/setup_poetry.sh

CURRENT_VERSION=$(poetry version)
echo -e "Finished. $CURRENT_VERSION\n"

./scripts/_aline.sh END "Download Poetry"
