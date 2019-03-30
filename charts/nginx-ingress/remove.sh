#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='nginx-ingress'

helm_delete $helm_release