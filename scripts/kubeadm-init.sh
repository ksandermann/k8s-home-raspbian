#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#on master node:

kubeadm init --experimental-upload-certs --config=/kubeadm-init/kubeadm.conf