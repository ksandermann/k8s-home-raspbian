# k8s-home-raspbian
Repository for configuration of a HA Kubernetes cluster bootstrapped with kubeadm running on 2 raspberrys 3, 2 raspberry 3b+ , 1 pine64 rockpro64 and 1 pine64 rock64

# Docker-image
in repo root:
```bash
./docker/build.sh 
./docker/run.sh
```


TODO 
* move dockerfile to separate repo and push to dockerhub
* prometheus
* grafana
* k8s-dashboard
* plex
* nfs-storage
* move k8s-configuration to ansible