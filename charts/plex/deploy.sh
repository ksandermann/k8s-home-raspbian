#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


helm_namespace='apps'

kubectl config set-context $(kubectl config current-context) --namespace=$helm_namespace

#copy tls secret to namespace
kubectl get secret sandermann.cloud --namespace=kubetools --export -o yaml | kubectl apply --namespace=$helm_namespace -f -

kubectl apply -f ./manifests/pvs.yaml
kubectl apply -f ./manifests --namespace=$helm_namespace

