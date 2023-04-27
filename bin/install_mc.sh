#!/usr/bin/env bash

filename=mc
curl -Lo /tmp/$filename https://dl.min.io/client/mc/release/linux-amd64/mc

mkdir -p ~/.local/bin
cp /tmp/$filename ~/.local/bin
chmod a+x ~/.local/bin/$filename

