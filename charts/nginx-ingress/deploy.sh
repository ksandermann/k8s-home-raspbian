#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

helm_namespace=kubetools
helm_release=nginx-ingress

kubectl config set-context $(kubectl config current-context) --namespace=$helm_namespace

helm upgrade $helm_release stable/nginx-ingress \
  --install \
  --version 1.4.0 \
  --namespace $helm_namespace \
  --dry-run \
  -f values.yaml

helm upgrade $helm_release stable/nginx-ingress \
  --install \
  --version 1.4.0 \
  --namespace $helm_namespace \
  -f values.yaml

kubectl get pods