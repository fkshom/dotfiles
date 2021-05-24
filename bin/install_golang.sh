#!/usr/bin/env bash

filename=go1.16.4.linux-amd64.tar.gz
curl -Lo /tmp/$filename https://golang.org/dl/go1.16.4.linux-amd64.tar.gz

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/$filename

rm /tmp/$filename

