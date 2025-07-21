# Solution: Create a Basic Pod

## Overview

This solution demonstrates how to create a basic Pod using both the imperative `kubectl run` command and declarative YAML approach. The key concepts covered are Pod creation, container specification, and label assignment.

## Step-by-Step Solution

### Method 1: Using kubectl run (Recommended for speed)

#### Step 1: Create the Pod with kubectl run

```bash
kubectl run web-server --image=nginx:1.20 --port=80 --labels="app=web,tier=frontend"
```

**Expected output:**
```
pod/web-server created
```

### Method 2: Using YAML manifest (Recommended for production)

#### Step 1: Generate YAML template

```bash
kubectl run web-server --image=nginx:1.20 --port=80 --labels="app=web,tier=frontend" --dry-run=client -o yaml > pod.yaml
```

#### Step 2: Apply the YAML manifest

```bash
kubectl apply -f pod.yaml
```

**Expected output:**
```
pod/web-server created
```

## YAML Manifest

The complete YAML manifest for this Pod:

```yaml
# File: manifests/pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-server
  namespace: default
  labels:
    app: web
    tier: frontend
spec:
  containers:
  - name: nginx-container
    image: nginx:1.20
    ports:
    - containerPort: 80
```

## Verification

### Final Verification Commands

```bash
# Check if Pod is running
kubectl get pods web-server

# Verify Pod details and labels
kubectl describe pod web-server

# Check Pod labels specifically
kubectl get pod web-server --show-labels

# Verify container image and port
kubectl get pod web-server -o jsonpath='{.spec.containers[0].image}'
```

### Expected Final State

```
NAME         READY   STATUS    RESTARTS   AGE
web-server   1/1     Running   0          30s
```

**Pod description should show:**
- Image: nginx:1.20
- Port: 80
- Labels: app=web, tier=frontend
- Status: Running

## Alternative Approaches

- **Imperative with separate label command**: Create Pod first, then add labels using `kubectl label`
- **YAML-first approach**: Write YAML manifest from scratch without using `--dry-run`
- **Using Pod template**: Create from a pre-existing Pod template

## Common Mistakes

- **Wrong image version**: Using `nginx:latest` instead of `nginx:1.20`
- **Missing labels**: Forgetting to add required labels or using wrong label format
- **Port confusion**: Not specifying the containerPort or using wrong port number
- **Name typos**: Misspelling the Pod name (remember it's `web-server` with hyphen)

## Key Learning Points

- **kubectl run syntax**: Essential command for quick Pod creation
- **Label assignment**: How to add labels during Pod creation
- **Port specification**: Understanding containerPort vs service port
- **Verification techniques**: Multiple ways to check Pod status and configuration
- **Imperative vs Declarative**: When to use each approach

## Related Documentation

- [Pod Concepts](https://kubernetes.io/docs/concepts/workloads/pods/)
- [kubectl run reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run)
- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)

---

**Time taken**: ⏱️ 2-3 minutes with kubectl run  
**Difficulty assessment**: Perfect starter question for CKAD fundamentals