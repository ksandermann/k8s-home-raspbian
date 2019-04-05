#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

haproxy -c -f ../configs/haproxy.cfg
echo "sleeping 5 sec"
sleep 5
scp ../configs/haproxy.cfg k8s-home-proxy1:/etc/haproxy/haproxy.cfg
scp ../configs/haproxy.cfg k8s-home-proxy2:/etc/haproxy/haproxy.cfg
ssh -o "StrictHostKeyChecking=no" k8s-home-proxy1 systemctl restart haproxy.service
ssh -o "StrictHostKeyChecking=no" k8s-home-proxy2 systemctl restart haproxy.service

scp ../configs/keepalived.proxy1.conf k8s-home-proxy1:/etc/keepalived/keepalived.conf
scp ../configs/keepalived.proxy2.conf k8s-home-proxy2:/etc/keepalived/keepalived.conf

ssh k8s-home-proxy1 systemctl restart keepalived.service
ssh k8s-home-proxy2 systemctl restart keepalived.service