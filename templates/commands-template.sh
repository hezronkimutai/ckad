#!/bin/bash

# Commands Template for CKAD Question Solutions
# Use this template to document the kubectl commands needed for a solution

# =============================================================================
# SETUP COMMANDS
# =============================================================================

# Create namespace (if required)
kubectl create namespace [namespace-name]

# Set context to use the namespace (optional but recommended)
kubectl config set-context --current --namespace=[namespace-name]

# =============================================================================
# MAIN SOLUTION COMMANDS
# =============================================================================

# Step 1: [Description of what this step does]
kubectl [command] [options]

# Step 2: [Description of what this step does]
kubectl [command] [options]

# Step 3: [Continue with additional steps]
kubectl [command] [options]

# =============================================================================
# VERIFICATION COMMANDS
# =============================================================================

# Verify the solution meets requirements
kubectl get [resources] -n [namespace]
kubectl describe [resource] [name] -n [namespace]
kubectl logs [pod-name] -c [container-name] -n [namespace]

# =============================================================================
# CLEANUP COMMANDS (Optional)
# =============================================================================

# Remove resources created during the exercise
kubectl delete [resource-type] [resource-name] -n [namespace]

# Remove namespace (if created)
kubectl delete namespace [namespace-name]

# =============================================================================
# COMMON KUBECTL PATTERNS FOR CKAD
# =============================================================================

# Quick resource creation with dry-run
# kubectl run [pod-name] --image=[image] --dry-run=client -o yaml > pod.yaml
# kubectl create deployment [name] --image=[image] --dry-run=client -o yaml > deployment.yaml
# kubectl create service clusterip [name] --tcp=[port]:[target-port] --dry-run=client -o yaml > service.yaml

# Expose resources
# kubectl expose pod [pod-name] --port=[port] --target-port=[target-port]
# kubectl expose deployment [deployment-name] --port=[port] --target-port=[target-port]

# Scale resources
# kubectl scale deployment [deployment-name] --replicas=[number]

# Update resources
# kubectl set image deployment/[deployment-name] [container-name]=[new-image]
# kubectl rollout restart deployment/[deployment-name]
# kubectl rollout status deployment/[deployment-name]
# kubectl rollout undo deployment/[deployment-name]

# Resource inspection
# kubectl get [resource] -o wide --show-labels
# kubectl get [resource] -o yaml
# kubectl get [resource] -o jsonpath='{[path]}'
# kubectl describe [resource] [name]

# Debugging and troubleshooting
# kubectl logs [pod-name] -c [container-name] --previous
# kubectl exec -it [pod-name] -- [command]
# kubectl port-forward [pod-name] [local-port]:[pod-port]
# kubectl top pods
# kubectl top nodes

# ConfigMaps and Secrets
# kubectl create configmap [name] --from-literal=[key]=[value]
# kubectl create configmap [name] --from-file=[file]
# kubectl create secret generic [name] --from-literal=[key]=[value]
# kubectl create secret docker-registry [name] --docker-server=[server] --docker-username=[user] --docker-password=[pass]

# RBAC
# kubectl create serviceaccount [name]
# kubectl create clusterrole [name] --verb=[verbs] --resource=[resources]
# kubectl create rolebinding [name] --clusterrole=[role] --serviceaccount=[namespace]:[sa-name]