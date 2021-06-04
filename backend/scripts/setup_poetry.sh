#!/usr/bin/env bash

echo -e "Sourcing Poetry.\n"

# Configure Poetry.   
. $PLATFORM_APP_DIR/.poetry/env
echo "export PATH=\"$HOME/.poetry/bin:$PATH\"" >> .global/environment
echo "export POETRY_VIRTUALENVS_PATH=$HOME/.virtualenvs" >> .global/environment
export PATH="$HOME/.poetry/bin:$PATH"
export PIP_USER=false
poetry config virtualenvs.path $HOME/.virtualenvs
