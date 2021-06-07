#!/usr/bin/env bash

./scripts/_aline.sh START "Setup Saleor"

# Source poetry environment variables
. ./scripts/setup_poetry.sh
export SECRET_KEY=$PLATFORM_PROJECT_ENTROPY

# Install dependencies.
cd ~/$PLATFORM_APPLICATION_NAME
poetry install --no-dev

# Download and setup Node, NPM, and NVM.
VERSIONS_FILE=../upstreams/versions.json
NVM_VERSION=$(cat $VERSIONS_FILE | jq -r '.nvm.version')
echo $NVM_VERSION
../scripts/download_nvm.sh $NVM_VERSION

# npm install
# poetry run python ~/$PLATFORM_APPLICATION_NAME/manage.py get_graphql_schema > ~/$PLATFORM_APPLICATION_NAME/saleor/graphql/schema.graphql
# npm run build-emails


# Collect static assets for Saleor.
# poetry run ~/$PLATFORM_APPLICATION_NAME/manage.py collectstatic --no-input

../scripts/_aline.sh END "Setup Saleor"