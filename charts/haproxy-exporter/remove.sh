#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_release='haproxy-exporter-k8s-home-proxy1'

helm_delete $helm_release

helm_release='haproxy-exporter-k8s-home-proxy2'

helm_delete $helm_release