#!/bin/bash
#in repo root:
docker run -ti --rm -v ~/.gitconfig:/root/.gitconfig -v ~/.kube:/root/.kube -v ~/.ssh:/root/.ssh -v ${PWD}/docker/files/.bashrc:/root/.bashrc -v ${PWD}:/k8s-home-raspbian ksandermann-k8s-client:1.14.0 bash
