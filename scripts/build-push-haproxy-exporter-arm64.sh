#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#on debian 9 arm64 machine with go installed
mkdir -p /root/git
cd /root/git
git clone https://github.com/prometheus/haproxy_exporter.git
cd haproxy_exporter
git checkout tags/v0.10.0
make build
docker build -t ksandermann/haproxy-exporter:v0.10.0arm64 .
docker push ksandermann/haproxy-exporter:v0.10.0arm64