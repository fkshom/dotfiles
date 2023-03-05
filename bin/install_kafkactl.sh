#!/usr/bin/env bash


function extract_from_tar(){
    archive_file=$1
    shift
    destination_dir=$1
    shift

    mkdir -p $destinatin_dir
    tar xf $archive_file -C $destination_dir $@
}

filename=kafkactl_3.0.3_linux_amd64.tar.gz
curl -Lo /tmp/$filename https://github.com/deviceinsight/kafkactl/releases/download/v3.0.3/kafkactl_3.0.3_linux_amd64.tar.gz

# extract_from_tar $filename ~/.local/bin kafkactl

mkdir -p ~/.local/bin
tar xf /tmp/$filename -C ~/.local/bin/ kafkactl
chmod a+x ~/.local/bin/kafkactl

mkdir -p ~/.local/share/bash-completions
~/.local/bin/kafkactl completion bash > ~/.local/share/bash-completions/_kafkactl

mkdir -p ~/.local/share/zsh-completions/
~/.local/bin/kafkactl completion zsh > ~/.local/share/zsh-completions/_kafkactl

rm /tmp/$filename

