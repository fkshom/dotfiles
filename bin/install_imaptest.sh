#!/usr/bin/env bash

. /etc/os-release
BINARY=imaptest-x86_64-ubuntu-${VERSION_ID}

mkdir -p ~/.local/bin
wget https://github.com/dovecot/imaptest/releases/download/latest/${BINARY} -O ~/.local/bin/imaptest &&\
    chmod +x ~/.local/bin/imaptest


