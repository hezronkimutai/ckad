# Solution: Create and Use ConfigMap

## Overview

This solution demonstrates ConfigMap creation and consumption through environment variables. Key concepts include external configuration management and Pod environment configuration.

## Step-by-Step Solution

### Step 1: Create the ConfigMap

```bash
kubectl create configmap app-config \
  --from-literal=database_url=postgresql://db.example.com:5432/appdb \
  --from-literal=debug_mode=true \
  --from-literal=max_connections=100
```

**Expected output:**
```
configmap/app-config created
```

### Step 2: Create Pod with ConfigMap environment variables

```bash
kubectl run config-consumer --image=nginx:1.20 --dry-run=client -o yaml > pod.yaml
```

Edit the YAML to include ConfigMap reference, then apply:

```bash
kubectl apply -f manifests/pod.yaml
```

**Expected output:**
```
pod/config-consumer created
```

## YAML Manifests

### ConfigMap YAML
```yaml
# File: manifests/configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: default
data:
  database_url: "postgresql://db.example.com:5432/appdb"
  debug_mode: "true"
  max_connections: "100"
```

### Pod YAML
```yaml
# File: manifests/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-consumer
  namespace: default
spec:
  containers:
  - name: nginx
    image: nginx:1.20
    envFrom:
    - configMapRef:
        name: app-config
```

## Verification

### Final Verification Commands

```bash
# Check ConfigMap
kubectl get configmap app-config
kubectl describe configmap app-config

# Check Pod
kubectl get pod config-consumer
kubectl describe pod config-consumer

# Verify environment variables
kubectl exec config-consumer -- env | grep -E "(database_url|debug_mode|max_connections)"
```

### Expected Final State

ConfigMap should contain all three key-value pairs, and Pod should be running with environment variables accessible.

## Key Learning Points

- ConfigMap creation with `--from-literal`
- Environment variable injection using `envFrom`
- ConfigMap data accessibility in containers
- External configuration management patterns

---

**Time taken**: ⏱️ 5-6 minutes  
**Difficulty assessment**: Good introduction to ConfigMaps and environment configuration