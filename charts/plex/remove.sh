#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='plex'
helm_namespace='apps'

helm_delete $helm_release


kubectl get pods --namespace=$helm_namespace