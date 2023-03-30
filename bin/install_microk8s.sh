#!/usr/bin/env bash

sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
microk8s.enable dns
microk8s.enable dashboard
microk8s.enable storage
#microk8s.enable metallb

#microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard --address 0.0.0.0 10443:443

sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

