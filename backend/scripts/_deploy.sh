#!/usr/bin/env bash

POPULATE_FILE="~/.demo/populated.txt"

cd ~/$PLATFORM_APPLICATION_NAME

# Apply database migrations.
poetry run python ~/$PLATFORM_APPLICATION_NAME/manage.py migrate

# Populate database with demo data. (Initial admin user created: admin@example.com/admin)
if [ "$USE_DEMO_DATA" = "true" ] && [ ! -f "$POPULATE_FILE"]; then
    poetry run python ~/$PLATFORM_APPLICATION_NAME/manage.py populatedb --createsuperuser  --withoutimages
    touch .demo/populated.txt
else
    poetry run python ~/$PLATFORM_APPLICATION_NAME/manage.py createsuperuser
    if [ -f "$POPULATE_FILE" ]; then
        rm -rf $POPULATE_FILE
    fi
fi
