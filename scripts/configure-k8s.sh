#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#set roles to nodes
kubectl label node k8s-home-node1 node-role.kubernetes.io/node=node
kubectl label node k8s-home-node2 node-role.kubernetes.io/node=node

#create ns and users
kubectl apply -f ../manifests/

echo "sleeping 5 sec for namespaces to be created successfully"
sleep 5

#install helm
helm init  \
    --tiller-namespace=kubetools \
    --service-account=tiller \
    --tiller-image=jessestuart/tiller:v2.13.1-arm64

#switch ns
kubectl config set-context $(kubectl config current-context) --namespace=kubetools