FROM ubuntu:16.04
LABEL maintainer="kevin.sandermann@gmail.com"

#env
ENV TILLER_NAMESPACE kubetools

#source
ARG HELM_CLIENT_SOURCE="https://storage.googleapis.com/kubernetes-helm/helm-v2.13.1-linux-amd64.tar.gz"

#set http(s) proxy for apt
RUN echo 'Acquire::http::Proxy "'${http_proxy}'";' >> /etc/apt/apt.conf.d/70proxy
RUN echo 'Acquire::https::Proxy "'${https_proxy}'";' >> /etc/apt/apt.conf.d/70proxy

RUN apt-get update && \
    apt-get install -y \
    bash-completion \
    curl \
    sudo \
    nano \
    telnet \
    iputils-ping \
    jq \
    git \
    haproxy \
    openssh-client

#Install Kubectl
RUN sudo apt-get update && sudo apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update && \
    sudo apt-get install -y kubectl=1.14.0-00

#Install Helm
WORKDIR "/home/root/download"
RUN curl -SsL $HELM_CLIENT_SOURCE | tar xz
RUN cp "/home/root/download/linux-amd64/helm" "/usr/local/bin/helm"
RUN chmod +x "/usr/local/bin/helm"

RUN helm init --client-only

WORKDIR "/k8s-home-raspbian"
