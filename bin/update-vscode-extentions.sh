#!/usr/bin/env bash

useragent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.40.1 Chrome/76.0.3809.146 Electron/6.1.2 Safari/537.3"

for extension in $(code --list-extensions); do
    name=${extension#*.}
    publisher=${extension%.*}
    version=$(curl -A "$useragent" https://marketplace.visualstudio.com/items?itemName="${extension}" | grep -oP '(?<="Version":")[^"]+(?=")')
    sleep 30

    echo $extension
    echo $publisher
    echo $name
    echo $version
    curl -LJO -A "$useragent" "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${publisher}/vsextensions/${name}/${version}/vspackage"
    filename="${extension}-${version}.vsix"
    code --install-extension $filename --force
    #wget --restrict-file-names=nocontrol \
    # --content-disposition \
    # --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:52.0) Gecko/20100101 Firefox/52.0" \
    # "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/${publisher}/vsextensions/${name}/${version}/vspackage" \
    # -P . 
    sleep 5
done



