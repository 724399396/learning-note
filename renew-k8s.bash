#!/bin/bash
kubeadm alpha certs renew all
docker kill `docker ps | grep apiserver | awk '{print $1}'`
docker kill `docker ps | grep controller-manager | awk '{print $1}'`
docker kill `docker ps | grep scheduler | awk '{print $1}'`
cp -nf /etc/kubernetes/admin.conf ~/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
systemctl restart kubelet
systemctl restart docker
