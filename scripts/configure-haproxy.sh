#!/bin/bash

haproxy -c -f ../configs/haproxy.cfg
echo "sleeping 5 sec"
sleep 5
scp ../configs/haproxy.cfg k8s-home-proxy1:/etc/haproxy/haproxy.cfg
ssh -o "StrictHostKeyChecking=no" k8s-home-proxy1 systemctl restart haproxy.service