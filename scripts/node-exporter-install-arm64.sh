#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p /tmp/downloads
cd /tmp/downloads
curl -sSLO https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-arm64.tar.gz
tar xfvz node_exporter-0.17.0.linux-arm64.tar.gz

cd /etc/systemd/system/
curl -sSLo - https://raw.githubusercontent.com/prometheus/node_exporter/master/examples/systemd/node_exporter.service \
  |sed -e 's|/etc/sysconfig/node_exporter|/etc/default/node_exporter|' |sed -e 's/^User.*//'  > node_exporter.service
curl -sSLo - https://raw.githubusercontent.com/prometheus/node_exporter/master/examples/systemd/sysconfig.node_exporter \
  |sed -e 's/^OPTIONS/#OPTIONS/;aOPTIONS=""' >/etc/default/node_exporter
cp /tmp/downloads/node_exporter-0.17.0.linux-arm64/node_exporter /usr/sbin/node_exporter
systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service

curl localhost:9100/metrics
systemctl status node_exporter.service

rm -rf /tmp/downloads