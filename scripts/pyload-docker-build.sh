#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#on aarch64
mkdir -p /root/dev && cd /root/dev
git clone https://github.com/obi12341/docker-pyload.git
cd docker-pyload
docker build -t ksandermann/pyload-aarch64:latest .
docker push ksandermann/pyload-aarch64:latest
now=$(date +'%Y-%m-%d')
docker tag ksandermann/pyload-aarch64:latest ksandermann/pyload-aarch64:$now
docker push ksandermann/pyload-aarch64:$now