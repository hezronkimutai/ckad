#!/bin/bash

# Worker node setup script
# This script joins worker nodes to the Kubernetes cluster

set -e

CONTROL_PLANE_IP=$1

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO] Setting up Kubernetes worker node...${NC}"

# Wait for join command to be available
echo -e "${YELLOW}[INFO] Waiting for join command from control plane...${NC}"
while [ ! -f /vagrant/join-command.sh ]; do
    sleep 5
    echo -e "${YELLOW}[INFO] Still waiting for join command...${NC}"
done

# Execute join command
echo -e "${YELLOW}[INFO] Joining the cluster...${NC}"
bash /vagrant/join-command.sh

# Configure kubectl for vagrant user (copy from control plane after joining)
echo -e "${YELLOW}[INFO] Waiting for cluster to be ready...${NC}"
sleep 30

# Configure kubectl for vagrant user
echo -e "${YELLOW}[INFO] Configuring kubectl for vagrant user...${NC}"
mkdir -p /home/vagrant/.kube

# Copy kubeconfig from control plane via shared folder
# Note: In production, you would use secure methods to distribute kubeconfig
while [ ! -f /vagrant/kubeconfig ]; do
    # Try to get kubeconfig from control plane
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null vagrant@${CONTROL_PLANE_IP} \
        "sudo cat /etc/kubernetes/admin.conf" > /vagrant/kubeconfig 2>/dev/null || true
    
    if [ ! -f /vagrant/kubeconfig ]; then
        echo -e "${YELLOW}[INFO] Waiting for kubeconfig to be available...${NC}"
        sleep 10
    fi
done

cp /vagrant/kubeconfig /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

# Set up the same aliases and functions as control plane
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

# Label the worker node for practice scenarios
HOSTNAME=$(hostname)
echo -e "${YELLOW}[INFO] Labeling worker node for practice...${NC}"

# Wait a bit more for the node to be fully ready
sleep 15

# Try to label the node (may fail if not fully ready yet)
kubectl --kubeconfig=/home/vagrant/.kube/config label node ${HOSTNAME} environment=production --overwrite || true

echo -e "${GREEN}[INFO] Worker node setup completed!${NC}"
echo -e "${GREEN}[INFO] Node ${HOSTNAME} has joined the cluster${NC}"

# Verify node status
kubectl --kubeconfig=/home/vagrant/.kube/config get nodes