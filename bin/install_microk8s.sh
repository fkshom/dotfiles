#!/usr/bin/env bash

sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
microk8s.enable dns
microk8s.enable storage

sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

