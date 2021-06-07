#!/usr/bin/env bash

cd $PLATFORM_APP_DIR
NVM_VERSION=$(cat $VERSIONS_FILE | jq -r '.nvm.version')
echo -e "\nDownloading NVM (\033[1m$VERSION\033[0m)\n"
export NODE_VERSION=$(cat ~/$PLATFORM_APPLICATION_NAME/.nvmrc)
unset NPM_CONFIG_PREFIX
export NVM_DIR="$PLATFORM_APP_DIR/.nvm"
if [ ! -d "$NVM_DIR/" ]; then
    # install.sh will automatically install NodeJS based on the presence of $NODE_VERSION
    curl -f -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
