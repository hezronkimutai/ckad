# Vagrant Kubernetes Cluster for CKAD Practice

This Vagrant configuration creates a multi-node Kubernetes cluster optimized for CKAD (Certified Kubernetes Application Developer) exam preparation.

## 🏗️ Cluster Architecture

The default configuration creates:

- **1 Control Plane Node** (`control-plane`)
  - IP: `192.168.56.10`
  - Memory: 2GB
  - CPUs: 2
  - Roles: Control plane, etcd, API server

- **2 Worker Nodes** (`worker-1`, `worker-2`)
  - IPs: `192.168.56.11`, `192.168.56.12`
  - Memory: 2GB each
  - CPUs: 2 each
  - Roles: Worker nodes for running workloads

## 📋 Prerequisites

### Required Software

1. **VirtualBox** (6.0 or later)
   ```bash
   # Ubuntu/Debian
   sudo apt update && sudo apt install virtualbox
   
   # macOS (with Homebrew)
   brew install --cask virtualbox
   
   # Windows: Download from https://www.virtualbox.org/
   ```

2. **Vagrant** (2.2 or later)
   ```bash
   # Ubuntu/Debian
   sudo apt install vagrant
   
   # macOS (with Homebrew)
   brew install vagrant
   
   # Windows: Download from https://www.vagrantup.com/
   ```

### System Requirements

- **RAM**: At least 8GB (6GB for VMs + 2GB for host)
- **CPU**: 4+ cores recommended
- **Disk**: 20GB free space
- **Network**: Internet connection for downloading images

## 🚀 Quick Start

### 1. Clone and Navigate

```bash
git clone https://github.com/hezronkimutai/ckad.git
cd ckad/vagrant
```

### 2. Start the Cluster

```bash
# Start all nodes (this will take 10-15 minutes)
vagrant up

# Or start nodes individually
vagrant up control-plane
vagrant up worker-1
vagrant up worker-2
```

### 3. Access the Cluster

```bash
# SSH into control plane
vagrant ssh control-plane

# Check cluster status
kubectl get nodes -o wide
kubectl get pods --all-namespaces
```

### 4. Configure Local kubectl (Optional)

```bash
# Copy kubeconfig to your local machine
vagrant ssh control-plane -c 'sudo cat /etc/kubernetes/admin.conf' > ~/.kube/ckad-config

# Use the config
export KUBECONFIG=~/.kube/ckad-config

# Update server IP to VM IP
sed -i 's/192.168.56.10:6443/192.168.56.10:6443/g' ~/.kube/ckad-config

# Test connection
kubectl get nodes
```

## 🛠️ Configuration Options

### Customizing the Cluster

Edit the `Vagrantfile` to modify:

```ruby
# Number of worker nodes (1-5 recommended)
NUM_WORKER_NODES = 2

# Kubernetes version
K8S_VERSION = "1.28.0"

# VM resources
VM_MEMORY = 2048  # MB
VM_CPUS = 2

# Network settings
CONTROL_PLANE_IP = "192.168.56.10"
WORKER_IP_BASE = "192.168.56.1"  # Workers get .11, .12, etc.
```

### Available Configurations

1. **Single Node Cluster** (for resource-constrained environments)
   ```ruby
   NUM_WORKER_NODES = 0
   VM_MEMORY = 4096  # Give more memory to control plane
   ```

2. **High Availability Setup** (advanced)
   ```ruby
   # Uncomment the load balancer section in Vagrantfile
   # Add multiple control plane nodes
   ```

## 🎯 CKAD Practice Features

### Pre-installed Tools

- **kubectl** with bash completion
- **crictl** for container runtime debugging
- **helm** for package management
- **yamllint** for YAML validation
- **jq** for JSON processing
- **tree** for directory visualization

### Practice Aliases

The cluster comes with CKAD-optimized aliases:

```bash
# Basic kubectl aliases
k           # kubectl
kgp         # kubectl get pods
kgs         # kubectl get services
kgd         # kubectl get deployments
kgn         # kubectl get nodes

# Describe commands
kdp         # kubectl describe pod
kds         # kubectl describe service
kdd         # kubectl describe deployment

# Other useful aliases
kaf         # kubectl apply -f
kdel        # kubectl delete
klog        # kubectl logs
kexec       # kubectl exec -it

# CKAD exam shortcuts
$do         # --dry-run=client -o yaml
$now        # --force --grace-period 0
```

### Practice Functions

```bash
# Quick namespace switching
kns production    # Switch to production namespace

# Quick YAML generation
krun nginx-pod nginx                    # Generate pod YAML
kcreate deployment nginx --image=nginx  # Generate deployment YAML

# Port forwarding
kpf pod/nginx 8080:80  # Port forward from pod
```

### Pre-configured Namespaces

- `ckad-practice` - Main practice namespace
- `production` - Production simulation
- `development` - Development environment
- `testing` - Testing environment

### Sample Resources

- ConfigMap: `sample-config` in `ckad-practice` namespace
- Secret: `sample-secret` in `ckad-practice` namespace
- Ingress Controller: NGINX Ingress
- Metrics Server: For `kubectl top` commands

## 🧪 Testing Your Setup

### Cluster Validation

```bash
# Check all nodes are ready
kubectl get nodes

# Verify system pods
kubectl get pods -n kube-system

# Test DNS resolution
kubectl run test-pod --image=busybox --rm -it -- nslookup kubernetes.default

# Test networking between nodes
kubectl run nginx --image=nginx
kubectl expose pod nginx --port=80
kubectl run test --image=busybox --rm -it -- wget -qO- nginx
```

### Practice Scenarios

```bash
# Create a simple pod
kubectl run practice-pod --image=nginx

# Create a deployment
kubectl create deployment practice-deploy --image=nginx --replicas=3

# Expose with a service
kubectl expose deployment practice-deploy --port=80 --type=NodePort

# Test connectivity
curl http://192.168.56.10:$(kubectl get svc practice-deploy -o jsonpath='{.spec.ports[0].nodePort}')
```

## 🔧 Cluster Management

### Common Operations

```bash
# Stop the cluster
vagrant halt

# Restart the cluster
vagrant up

# Destroy the cluster
vagrant destroy -f

# Check VM status
vagrant status

# SSH into specific node
vagrant ssh control-plane
vagrant ssh worker-1
```

### Troubleshooting

#### Cluster Not Starting

```bash
# Check VirtualBox VMs
VBoxManage list runningvms

# Check vagrant status
vagrant status

# View detailed logs
vagrant up --debug
```

#### Network Issues

```bash
# Check VM network configuration
vagrant ssh control-plane -c "ip addr show"

# Verify Kubernetes network
kubectl get pods -n kube-system | grep calico
```

#### Resource Issues

```bash
# Check system resources
vagrant ssh control-plane -c "free -h && df -h"

# Monitor resource usage
kubectl top nodes
kubectl top pods --all-namespaces
```

### Performance Optimization

1. **Increase VM Resources**
   ```ruby
   VM_MEMORY = 4096  # Increase to 4GB
   VM_CPUS = 4       # Use more CPU cores
   ```

2. **Reduce Worker Nodes**
   ```ruby
   NUM_WORKER_NODES = 1  # Use fewer workers
   ```

3. **Enable VirtualBox Features**
   ```ruby
   vb.customize ["modifyvm", :id, "--vtxvpid", "on"]
   vb.customize ["modifyvm", :id, "--vtxux", "on"]
   ```

## 📚 CKAD Practice Tips

### Exam Simulation

1. **Time Constraints**: Practice with 15-20 minute limits per question
2. **Command Line Focus**: Minimize YAML editing, maximize kubectl commands
3. **Speed Optimization**: Use aliases and bash completion
4. **Resource Cleanup**: Always clean up resources after practice

### Best Practices

```bash
# Always use dry-run first
kubectl run test --image=nginx $do

# Generate YAML and modify
kubectl create deployment test --image=nginx $do > deploy.yaml
# Edit deploy.yaml
kubectl apply -f deploy.yaml

# Use imperative commands when possible
kubectl create secret generic mysecret --from-literal=key=value
kubectl create configmap myconfig --from-literal=app=myapp

# Quick resource inspection
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl describe pod podname | grep -A 10 Events
```

## 🔄 Updates and Maintenance

### Updating Kubernetes Version

1. Modify `K8S_VERSION` in `Vagrantfile`
2. Destroy and recreate cluster:
   ```bash
   vagrant destroy -f
   vagrant up
   ```

### Adding Features

1. Modify setup scripts in `scripts/` directory
2. Recreate cluster or apply changes manually

### Backup and Restore

```bash
# Backup etcd (from control plane)
sudo ETCDCTL_API=3 etcdctl snapshot save /tmp/backup.db

# Restore (advanced - see Kubernetes documentation)
```

## ❓ FAQ

**Q: Can I run this on Windows?**
A: Yes, but ensure you have VirtualBox and Vagrant installed. WSL2 is recommended.

**Q: How much resources does this use?**
A: Default configuration uses ~6GB RAM and 4 CPU cores across all VMs.

**Q: Can I access applications from my host machine?**
A: Yes, use NodePort services and access via VM IPs (192.168.56.10-12).

**Q: How do I add more storage?**
A: Modify the Vagrantfile to add additional disks or increase root filesystem.

**Q: Can I use this for production?**
A: No, this is designed for learning only. Use managed Kubernetes for production.

## 🤝 Contributing

Issues and improvements to the Vagrant setup are welcome! Please:

1. Test changes thoroughly
2. Update documentation
3. Ensure compatibility across platforms
4. Follow the existing configuration patterns

---

**Happy CKAD practicing! 🚀**

For more practice questions and solutions, return to the main repository: [`../README.md`](../README.md)