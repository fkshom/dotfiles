#!/usr/bin/env bash

echo "Install pyenv"

sudo apt update
sudo apt install -y build-essential libreadline-dev zlib1g-dev libsqlite3-dev libbz2-dev libssl-dev libffi-dev

if [ -d $HOME/.pyenv ]; then
  (cd $HOME/.pyenv; git pull)
else
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
  $HOME/.poetry/bin/poetry config virtualenvs.in-project true
fi

echo "Finished"

