#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

kubectl config set-context $(kubectl config current-context) --namespace kubetools

helm upgrade nginx-ingress ../../chart \
  --install \
  --namespace kubetools \
  --dry-run \
  -f values.yaml
