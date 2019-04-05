#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#on arm64 debian 9:
mkdir -p /root/dev && cd /root/dev
git clone https://github.com/munnerz/kube-plex.git

docker run -it --rm -v ${PWD}/kube-plex:/go/src/github.com/munnerz/kube-plex golang:1.9.0-stretch bash

#in docker container:
sed -i 's/amd64/arm64/g' /go/src/github.com/munnerz/kube-plex/main.go
cd /go/src/github.com/munnerz/kube-plex/
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o kube-plex github.com/munnerz/kube-plex
mv kube-plex kube-plex_linux_amd64

#terminate docker container:
cd /root/dev/kube-plex
docker build -t ksandermann/kube-plex:arm64 .
docker push ksandermann/kube-plex:arm64