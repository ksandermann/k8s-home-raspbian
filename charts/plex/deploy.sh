#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_chart='./chart/kube-plex/charts/kube-plex'
helm_chart_version='0.2.3'
helm_release='plex'
helm_namespace='apps'
helm_values_filepath='values.yaml'

#copy tls secret to namespace
kubectl get secret sandermann.cloud --namespace=kubetools --export -o yaml | kubectl apply --namespace=$helm_namespace -f -

#kubectl apply -f ./manifests --namespace=$helm_namespace
#
#
#helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath
#
#helm_deploy $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath
#
#helm_check_all_pods_successful $helm_release

kubectl apply -f manifests