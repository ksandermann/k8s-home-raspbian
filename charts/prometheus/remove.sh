#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='prometheus'
helm_namespace='kubetools'

helm_delete $helm_release

kubectl delete -f ./manifests --namespace=$helm_namespace