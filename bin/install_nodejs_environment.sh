#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
git clone --depth=1 https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
source nvm.sh
nvm install --lts

