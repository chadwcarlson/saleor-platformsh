#!/usr/bin/env bash

# Source poetry environment variables
. ./scripts/setup_poetry.sh

# Install dependencies.
cd ~/$PLATFORM_APPLICATION_NAME
poetry install -v --no-dev

# NPM - version?
npm -v
node -v
npm install
poetry run python ~/$PLATFORM_APPLICATION_NAME/manage.py get_graphql_schema > ~/$PLATFORM_APPLICATION_NAME/saleor/graphql/schema.graphql
npm run build-emails


# Collect static assets for Saleor.
SECRET_KEY=$PLATFORM_PROJECT_ENTROPY poetry run ~/$PLATFORM_APPLICATION_NAME/manage.py collectstatic --no-input