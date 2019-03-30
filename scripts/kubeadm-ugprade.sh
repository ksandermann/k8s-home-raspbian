#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#on master node:

kubeadm upgrade plan 1.14.0 --config=/kubeadm-init/kubeadm.conf

kubeadm upgrade apply 1.14.0 --config=/kubeadm-init/kubeadm.conf