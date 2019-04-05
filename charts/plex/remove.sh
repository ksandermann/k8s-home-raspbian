#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

helm_namespace='apps'


kubectl delete -f ./manifests --namespace=$helm_namespace

kubectl delete -f ./manifests/pvs.yaml

kubectl get pods --namespace=$helm_namespace