#!/usr/bin/env bash

VERSION=v4.23.1
BINARY=yq_linux_amd64

mkdir -p ~/.local/bin
wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O ~/.local/bin/yq &&\
    chmod +x ~/.local/bin/yq

