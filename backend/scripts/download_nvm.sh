#!/usr/bin/env bash

# Check build cache usage https://gist.github.com/devicezero/b38ed48bccaef72a0ab24293552992d8
VERSION=$1
echo -e "\nDownloading NVM (\033[1m$VERSION\033[0m)\n"
pwd
NODE_VERSION=$(cat .nvmrc)
unset NPM_CONFIG_PREFIX
export NVM_DIR="$PLATFORM_APP_DIR/.nvm"
if [ ! -d "$NVM_DIR/" ]; then
    # install.sh will automatically install NodeJS based on the presence of $NODE_VERSION
    curl -f -o- https://raw.githubusercontent.com/nvm-sh/nvm/$ERSION/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
