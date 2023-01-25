#!/usr/bin/env bash

VERSION=v1.0.3
BINARY=kerbrute_linux_amd64

mkdir -p ~/.local/bin
wget https://github.com/ropnop/kerbrute/releases/download/${VERSION}/${BINARY} -O ~/.local/bin/kerbrute &&\
    chmod +x ~/.local/bin/kerbrute

