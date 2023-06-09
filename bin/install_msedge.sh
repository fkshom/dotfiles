#!/usr/bin/env bash

filename=msedge.deb
curl -Lo /tmp/$filename "https://go.microsoft.com/fwlink?linkid=2149051&brand=M102_.%"

sudo dpkg -i /tmp/$filename
rm /tmp/$filename

