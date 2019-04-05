#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='plex'
helm_namespace='apps'

helm_delete $helm_release
kubectl delete -f ./manifests --namespace=$helm_namespace
kubectl get pods --namespace=$helm_namespace

kubectl delete -f manifests