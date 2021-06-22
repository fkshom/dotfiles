#!/usr/bin/env bash

echo "Install rbenv"

sudo apt update
sudo apt install -y build-essential libreadline-dev zlib1g-dev libsqlite3-dev libbz2-dev libssl-dev

if [ -d $HOME/.rbenv ]; then
  (cd $HOME/.rbenv; git pull)
else
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

echo "Finished"
echo "`bundle config set --local path 'vendor/bundle'"

