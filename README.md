# k8s-home-raspbian
Repository for configuration of a HA Kubernetes cluster bootstrapped with kubeadm running on 2 raspberrys 3, 2 raspberry 3b+ , 1 pine64 rockpro64 and 1 pine64 rock64

# Docker-image
in repo root:
```bash
./docker/build.sh 
./docker/run.sh
```

# NFS
In order for NFS (I am using v3) to be handled by the Nodes, nfs-common is needed:

`apt-get update && apt-get install -qy nfs-common`

# TODO 
* [ ] move dockerfile to separate repo and push to dockerhub
* [ ] grafana
* [ ] plex
* [ ] ansible-tower
* [ ] scripts to ansible
* [ ] pyload helm chart + deployment
* [ ] nextcloud
* [ ] architecture documentation
  * [ ] picture
  * [ ] hardware
  * [ ] OS
  * [ ] pricing
  * [ ] background
* [ ] fritzbox tls termination through ingress
* [ ] ansible script raspbian /debian bootstrapping
