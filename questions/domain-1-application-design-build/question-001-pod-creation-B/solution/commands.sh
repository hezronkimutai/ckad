#!/bin/bash

# Solution Commands for Question 001: Create a Basic Pod

# =============================================================================
# METHOD 1: Using kubectl run (Fastest approach for exam)
# =============================================================================

# Create the Pod with all specifications in one command
kubectl run web-server --image=nginx:1.20 --port=80 --labels="app=web,tier=frontend"

# =============================================================================
# METHOD 2: Using YAML manifest (Best practice approach)
# =============================================================================

# Generate YAML template (optional step for learning)
kubectl run web-server --image=nginx:1.20 --port=80 --labels="app=web,tier=frontend" --dry-run=client -o yaml > pod.yaml

# Apply the YAML manifest
kubectl apply -f manifests/pod.yaml

# =============================================================================
# VERIFICATION COMMANDS
# =============================================================================

# Check if Pod is running
kubectl get pods web-server

# Verify Pod details and configuration
kubectl describe pod web-server

# Check Pod labels specifically
kubectl get pod web-server --show-labels

# Verify container image
kubectl get pod web-server -o jsonpath='{.spec.containers[0].image}'

# Check container port configuration
kubectl get pod web-server -o jsonpath='{.spec.containers[0].ports[0].containerPort}'

# Get Pod status
kubectl get pod web-server -o jsonpath='{.status.phase}'

# =============================================================================
# CLEANUP COMMANDS (Optional)
# =============================================================================

# Remove the Pod after testing
kubectl delete pod web-server

# Alternative cleanup using YAML file
# kubectl delete -f manifests/pod.yaml

# =============================================================================
# ALTERNATIVE APPROACHES
# =============================================================================

# Method 3: Create Pod first, then add labels
# kubectl run web-server --image=nginx:1.20 --port=80
# kubectl label pod web-server app=web tier=frontend

# Method 4: Using multiple commands for better understanding
# kubectl run web-server --image=nginx:1.20
# kubectl patch pod web-server -p '{"spec":{"containers":[{"name":"nginx-container","ports":[{"containerPort":80}]}]}}'
# kubectl label pod web-server app=web tier=frontend

# =============================================================================
# TROUBLESHOOTING COMMANDS
# =============================================================================

# If Pod fails to start, check events
# kubectl describe pod web-server | grep -A 10 Events

# Check Pod logs (useful if container crashes)
# kubectl logs web-server

# Get detailed Pod information in YAML format
# kubectl get pod web-server -o yaml