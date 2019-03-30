#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

kubectl config set-context $(kubectl config current-context) --namespace kubetools
helm delete --purge nginx-ingress