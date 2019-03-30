#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../../scripts/helm-functions.sh

helm_chart='stable/metrics-server'
helm_chart_version='2.5.1'
helm_release='metrics-server'
helm_namespace='kubetools'
helm_values_filepath='values.yaml'


helm_dryrun $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_deploy $helm_chart $helm_chart_version $helm_release $helm_namespace $helm_values_filepath

helm_check_all_pods_successful $helm_release