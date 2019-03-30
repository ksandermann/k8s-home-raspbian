#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

helm_deploy() {
local helm_chart=$1
local helm_chart_version=$2
local helm_release=$3
local helm_namespace=$4
local helm_values_filepath=$5

kubectl config set-context $(kubectl config current-context) --namespace=$helm_namespace

helm upgrade $helm_release $helm_chart \
  --install \
  --version $helm_chart_version \
  --namespace $helm_namespace \
  -f $helm_values_filepath
}

helm_dryrun() {
local helm_chart=$1
local helm_chart_version=$2
local helm_release=$3
local helm_namespace=$4
local helm_values_filepath=$5

kubectl config set-context $(kubectl config current-context) --namespace=$helm_namespace

helm upgrade $helm_release $helm_chart \
  --install \
  --version $helm_chart_version \
  --namespace $helm_namespace \
  --dry-run \
  -f $helm_values_filepath
}

helm_delete() {
local helm_release=$1
helm del --purge $helm_release
sleep 1
kubectl get pods --all-namespaces --include-uninitialized --selector=release=$helm_release
}


helm_check_all_pods_successful() {
echo "Checking every 5 seconds for 5 minutes if all pods started successfully..."
echo "Waiting 5 seconds before first check to ensure terminating pods are marked as terminating..."
sleep 5
iteration=1
allPodsSucceeded=false
until [[ "$allPodsSucceeded" == "true" ]] || [[ "$iteration" -ge 60 ]]; do
    local podPhases=$(kubectl get pods --all-namespaces --include-uninitialized --selector=release=$1 -o json | jq .items[].status.phase)
    allPodsSucceeded=true
    case "$podPhases" in
    #https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase
      *Pending*)
        echo "There are pods in Pending phase."
        allPodsSucceeded=false
        ;;
      *Running*)
        echo "There are pods in Running phase."
        ;;
      *Succeeded*)
        echo "There are pods in Succeeded phase."
        ;;
      *Failed*)
        echo "There are pods in Failed phase."
        allPodsSucceeded=false
        ;;
      *Unknown*)
        echo "There are pods in Unknown phase."
        allPodsSucceeded=false
        ;;
      *Completed*)
        echo "There are pods in Completed phase."
        ;;
      *CrashLoopBackOff*)
        echo "There are pods in CrashLoopBackOff phase."
        allPodsSucceeded=false
        ;;
    esac

    ((iteration++))
    sleep 5

done

kubectl get pods --all-namespaces --include-uninitialized --selector=release=$1

if [[ "$iteration" -ge 60 ]]; then
    echo "ERROR: Not all pods of helm release $1 started successfully!"
    exit 1
else
    echo "All pods of helm release $1 are up and running!"
fi


}