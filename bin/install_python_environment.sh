#!/usr/bin/env bash

echo "Install pyenv"

last_update=$(stat -c %Y /var/cache/apt/pkgcache.bin)
now=$(date +%s)
if [ $((now - last_update)) -gt 3600 ]; then
    sudo apt-get update
fi
sudo apt install -y build-essential libreadline-dev zlib1g-dev libsqlite3-dev libbz2-dev libssl-dev libffi-dev curl python3-distutils python3-venv

if [ ! -d $HOME/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
else
  (cd $HOME/.pyenv; git pull)
fi

if [ ! -d $HOME/.poetry ]; then
  if [[ "`python3 --version`" < "3.7.0" ]]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
    $HOME/.poetry/bin/poetry config virtualenvs.in-project true
  else
    curl -sSL https://install.python-poetry.org | python3 -
    $HOME/.local/bin/poetry config virtualenvs.in-project true
    #poetry completions bash > /etc/bash_completion.d/poetry
    #poetry completions zsh > ~/.zfunc/_poetry
  fi
fi

echo "Finished"

