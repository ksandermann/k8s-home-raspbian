#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_chart='./helm-chart-haproxy-exporter'
helm_chart_version='1.0.0'
helm_release='haproxy-exporter-k8s-home-proxy1'
helm_namespace='kubetools'
helm_values_filepath='values-proxy1.yaml'

helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_deploy_recreate_pods $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_check_all_pods_successful $helm_release




helm_chart='./helm-chart-haproxy-exporter'
helm_chart_version='1.0.0'
helm_release='haproxy-exporter-k8s-home-proxy2'
helm_namespace='kubetools'
helm_values_filepath='values-proxy2.yaml'

helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_deploy_recreate_pods $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_check_all_pods_successful $helm_release

