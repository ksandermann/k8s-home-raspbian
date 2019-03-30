#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='kubernetes-dashboard'

helm_delete $helm_release