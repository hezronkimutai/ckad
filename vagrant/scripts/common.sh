#!/bin/bash

# Common setup script for all Kubernetes nodes
# This script installs Docker, kubeadm, kubelet, and kubectl

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO] Starting common node setup...${NC}"

# Update system packages
echo -e "${YELLOW}[INFO] Updating system packages...${NC}"
apt-get update -y
apt-get upgrade -y

# Install required packages
echo -e "${YELLOW}[INFO] Installing required packages...${NC}"
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    net-tools \
    htop \
    vim

# Disable swap (required for Kubernetes)
echo -e "${YELLOW}[INFO] Disabling swap...${NC}"
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Configure kernel modules
echo -e "${YELLOW}[INFO] Configuring kernel modules...${NC}"
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# Configure sysctl parameters
echo -e "${YELLOW}[INFO] Configuring sysctl parameters...${NC}"
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

# Install containerd
echo -e "${YELLOW}[INFO] Installing containerd...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y containerd.io

# Configure containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

# Enable SystemdCgroup
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

systemctl restart containerd
systemctl enable containerd

# Install Kubernetes components
echo -e "${YELLOW}[INFO] Installing Kubernetes components...${NC}"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update -y
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Enable kubelet
systemctl enable kubelet

# Configure crictl
echo -e "${YELLOW}[INFO] Configuring crictl...${NC}"
cat <<EOF | tee /etc/crictl.yaml
runtime-endpoint: unix:///run/containerd/containerd.sock
image-endpoint: unix:///run/containerd/containerd.sock
timeout: 2
debug: false
pull-image-on-create: false
EOF

# Install helpful tools for CKAD practice
echo -e "${YELLOW}[INFO] Installing CKAD practice tools...${NC}"
apt-get install -y \
    bash-completion \
    tree \
    jq \
    yamllint

# Configure kubectl bash completion
echo 'source <(kubectl completion bash)' >> /home/vagrant/.bashrc
echo 'alias k=kubectl' >> /home/vagrant/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /home/vagrant/.bashrc

# Configure vim for YAML editing
cat <<EOF >> /home/vagrant/.vimrc
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
syntax on
EOF

chown vagrant:vagrant /home/vagrant/.vimrc

echo -e "${GREEN}[INFO] Common node setup completed successfully!${NC}"