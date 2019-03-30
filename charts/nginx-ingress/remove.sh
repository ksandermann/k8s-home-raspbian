#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='nginx-ingress'
helm_namespace='kubetools'

helm_delete $helm_release

kubectl delete secret sandermann.cloud --namespace=$helm_namespace

kubectl get pods --namespace=$helm_namespace