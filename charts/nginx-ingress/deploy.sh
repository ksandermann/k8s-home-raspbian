#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_chart='stable/nginx-ingress'
helm_chart_version='1.4.0'
helm_release='nginx-ingress'
helm_namespace='kubetools'
helm_values_filepath='values.yaml'

# create tls secret
kubectl create secret tls sandermann.cloud --namespace=$helm_namespace --key ../../certs/sandermann.cloud.privkey.pem --cert ../../certs/sandermann.cloud.fullchain.pem --dry-run -o yaml | kubectl apply -f -


# deploy nginx-ingress

helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_deploy $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_check_all_pods_successful $helm_release