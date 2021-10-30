#!/usr/bin/env bash

filename=ghq_linux_amd64.zip
curl -Lo /tmp/$filename https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip

mkdir -p ~/.local/bin
unzip -p /tmp/$filename ghq_linux_amd64/ghq > ~/.local/bin/ghq
chmod a+x ~/.local/bin/ghq

mkdir -p ~/.local/share/bash-completions
unzip -p /tmp/$filename ghq_linux_amd64/misc/bash/_ghq > ~/.local/share/bash-completions/_ghq

mkdir -p ~/.local/share/zsh-completions/
unzip -p /tmp/$filename ghq_linux_amd64/misc/zsh/_ghq > ~/.local/share/zsh-completions/_ghq

rm /tmp/$filename

(cd ~; ln -sf .ghq ghq)
