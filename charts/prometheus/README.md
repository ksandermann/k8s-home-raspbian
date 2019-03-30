# Chart-Adjustments

I decided to simply remove the configmap-reload container from the prometheus chart and set Update.Strategy to Recreate
Before, I was building the configmap-reload container myself for debian 9 aarch64, but I switched to above solution so I 
don't need to build that anymore.
Also, adjusting the deployment with sed seemed too dirty.

For completion purposes, the documentation on how to build the container is still below.


# building jimmidyson/configmap-reload for arm64

on debian 9 arm64-machine:
```bash
mkdir -p /root/git
cd /root/git
git clone https://github.com/jimmidyson/configmap-reload.git
cd configmap-reload
git checkout tags/v0.2.2
apt-get update
apt-get install make
wget https://dl.google.com/go/go1.12.1.linux-arm64.tar.gz
sudo tar -C /usr/local -xzf go1.12.1.linux-arm64.tar.gz
export PATH=$PATH:/usr/local/go/bin
mkdir -p /root/go/bin
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
export GOPATH=/root/git/configmap-reload
```

in Makefile:
replace dep with /root/go/bin/dep


```golang
out/configmap-reload-linux-arm64: vendor configmap-reload.go $(shell $(SRCFILES))
        $(MKGOPATH)
        cd $(GOPATH)/src/$(REPOPATH) && CGO_ENABLED=0 GOARCH=arm64 GOOS=linux go build --installsuffix cgo -ldflags="$(LDFLAGS)" -a -o $(BUILD_DIR)/configmap-reload-linux-arm64 configmap-reload.go
```



then:
```bash
make
docker build -t cfg-reload:arm64 .
```