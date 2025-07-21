#!/bin/bash

# Control plane setup script
# This script initializes the Kubernetes control plane node

set -e

CONTROL_PLANE_IP=$1
K8S_VERSION=$2
CALICO_VERSION=$3

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO] Setting up Kubernetes control plane...${NC}"

# Initialize Kubernetes cluster
echo -e "${YELLOW}[INFO] Initializing Kubernetes cluster...${NC}"
kubeadm init \
    --apiserver-advertise-address=${CONTROL_PLANE_IP} \
    --control-plane-endpoint=${CONTROL_PLANE_IP} \
    --node-name=control-plane \
    --pod-network-cidr=192.168.0.0/16 \
    --kubernetes-version=${K8S_VERSION}

# Configure kubectl for root user
echo -e "${YELLOW}[INFO] Configuring kubectl for root user...${NC}"
mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config
chown root:root /root/.kube/config

# Configure kubectl for vagrant user
echo -e "${YELLOW}[INFO] Configuring kubectl for vagrant user...${NC}"
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

# Install Calico CNI
echo -e "${YELLOW}[INFO] Installing Calico CNI...${NC}"
curl https://raw.githubusercontent.com/projectcalico/calico/${CALICO_VERSION}/manifests/tigera-operator.yaml -O
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f tigera-operator.yaml

# Create Calico configuration
cat <<EOF | kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f -
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  calicoNetwork:
    ipPools:
    - blockSize: 26
      cidr: 192.168.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()
---
apiVersion: operator.tigera.io/v1
kind: APIServer
metadata:
  name: default
spec: {}
EOF

# Wait for Calico to be ready
echo -e "${YELLOW}[INFO] Waiting for Calico to be ready...${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf wait --for=condition=Ready nodes --all --timeout=300s

# Generate join command for worker nodes
echo -e "${YELLOW}[INFO] Generating join command for worker nodes...${NC}"
kubeadm token create --print-join-command > /vagrant/join-command.sh
chmod +x /vagrant/join-command.sh

# Install Metrics Server (for kubectl top commands)
echo -e "${YELLOW}[INFO] Installing Metrics Server...${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Patch metrics server to work in development environment
kubectl --kubeconfig=/etc/kubernetes/admin.conf patch deployment metrics-server -n kube-system --type='json' -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/containers/0/args/-",
    "value": "--kubelet-insecure-tls"
  }
]'

# Install sample applications for practice
echo -e "${YELLOW}[INFO] Setting up practice namespaces...${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create namespace ckad-practice
kubectl --kubeconfig=/etc/kubernetes/admin.conf create namespace production
kubectl --kubeconfig=/etc/kubernetes/admin.conf create namespace development
kubectl --kubeconfig=/etc/kubernetes/admin.conf create namespace testing

# Label nodes for practice scenarios
kubectl --kubeconfig=/etc/kubernetes/admin.conf label node control-plane node-role.kubernetes.io/control-plane=
kubectl --kubeconfig=/etc/kubernetes/admin.conf label node control-plane environment=development

# Create sample ConfigMap and Secret for practice
echo -e "${YELLOW}[INFO] Creating sample resources for practice...${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create configmap sample-config \
    --from-literal=app.name=ckad-practice \
    --from-literal=app.version=1.0 \
    -n ckad-practice

kubectl --kubeconfig=/etc/kubernetes/admin.conf create secret generic sample-secret \
    --from-literal=username=admin \
    --from-literal=password=secretpassword \
    -n ckad-practice

# Install ingress controller (NGINX)
echo -e "${YELLOW}[INFO] Installing NGINX Ingress Controller...${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/baremetal/deploy.yaml

# Create useful aliases and functions for CKAD practice
echo -e "${YELLOW}[INFO] Setting up CKAD practice environment...${NC}"
cat <<'EOF' >> /home/vagrant/.bashrc

# CKAD Practice Aliases and Functions
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias klog='kubectl logs'
alias kexec='kubectl exec -it'

# Quick namespace switching
function kns() {
    kubectl config set-context --current --namespace=$1
}

# Quick dry-run YAML generation
function krun() {
    kubectl run $1 --image=$2 --dry-run=client -o yaml
}

function kcreate() {
    kubectl create $@ --dry-run=client -o yaml
}

# Quick port forwarding
function kpf() {
    kubectl port-forward $1 $2:$3
}

# Export KUBECONFIG
export KUBECONFIG=/home/vagrant/.kube/config

# CKAD exam settings simulation
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"

EOF

chown vagrant:vagrant /home/vagrant/.bashrc

# Display cluster information
echo -e "${GREEN}[INFO] Control plane setup completed!${NC}"
echo -e "${GREEN}[INFO] Cluster Information:${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf cluster-info
echo -e "${GREEN}[INFO] Nodes:${NC}"
kubectl --kubeconfig=/etc/kubernetes/admin.conf get nodes -o wide

echo -e "${YELLOW}[INFO] Join command saved to /vagrant/join-command.sh${NC}"
echo -e "${GREEN}[INFO] Control plane is ready for CKAD practice!${NC}"