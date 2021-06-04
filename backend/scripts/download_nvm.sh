#!/usr/bin/env bash

# Check build cache usage https://gist.github.com/devicezero/b38ed48bccaef72a0ab24293552992d8

unset NPM_CONFIG_PREFIX
export NVM_DIR="$PLATFORM_APP_DIR/.nvm"
if [ ! -d "$NVM_DIR/" ]; then
    # install.sh will automatically install NodeJS based on the presence of $NODE_VERSION
    curl -f -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
