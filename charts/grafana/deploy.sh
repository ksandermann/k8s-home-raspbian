#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_chart='stable/grafana'
helm_chart_version='3.0.1'
helm_release='grafana'
helm_namespace='apps'
helm_values_filepath='values.yaml'


#copy tls secret to namespace
kubectl get secret sandermann.cloud --namespace=kubetools --export -o yaml | kubectl apply --namespace=$helm_namespace -f -

kubectl apply -f ./manifests --namespace=$helm_namespace
kubectl apply -f ./dashboards --namespace=$helm_namespace
kubectl apply -f ./manifests

helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_deploy_recreate_pods $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_check_all_pods_successful $helm_release