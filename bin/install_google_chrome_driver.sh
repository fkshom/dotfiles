#!/usr/bin/env bash

cd /tmp

if type google-chrome >/dev/null; then
    version=`google-chrome --version | sed -e "s/Google Chrome //" -e "s/ //g"`
else
    version=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
fi

wget "https://chromedriver.storage.googleapis.com/${version}/chromedriver_linux64.zip"
sudo unzip -o chromedriver_linux64.zip chromedriver -d /usr/local/bin
rm chromedriver_linux64.zip

