# Domain 1: Application Design and Build (20%)

This domain covers the fundamental skills for designing and building containerized applications in Kubernetes.

## Domain Objectives

Based on the CKAD curriculum, this domain covers:

- **Define, build and modify container images**
  - Understanding Dockerfile syntax and best practices
  - Building container images
  - Working with image registries

- **Understand Jobs and CronJobs**
  - Creating and managing batch workloads
  - Configuring job completion and parallelism
  - Scheduling recurring tasks

- **Understand multi-container Pod design patterns**
  - Sidecar pattern
  - Ambassador pattern
  - Adapter pattern
  - Init containers

## Available Questions

### Basic Level

| Question | Topic | Time | Description |
|----------|-------|------|-------------|
| [001](./question-001-pod-creation-B/) | Pod Creation | 5 min | Create a basic Pod with specific image and labels |

### Intermediate Level

| Question | Topic | Time | Description |
|----------|-------|------|-------------|
| *Coming soon* | Multi-container Pod | 10 min | Pod with sidecar container pattern |
| *Coming soon* | Init Containers | 10 min | Pod with initialization logic |
| *Coming soon* | Job Creation | 8 min | Batch processing with Jobs |

### Advanced Level

| Question | Topic | Time | Description |
|----------|-------|------|-------------|
| *Coming soon* | CronJob | 15 min | Scheduled batch processing |
| *Coming soon* | Complex Multi-container | 20 min | Advanced pod design patterns |

## Practice Strategy

### For Beginners
1. Start with basic Pod creation questions
2. Practice kubectl run commands for speed
3. Learn YAML structure through examples
4. Focus on verification commands

### For Intermediate
1. Explore multi-container patterns
2. Practice Job and CronJob scenarios
3. Learn resource requirements and limits
4. Practice debugging failing containers

### For Advanced
1. Master complex pod designs
2. Practice container image building
3. Optimize for exam time constraints
4. Focus on real-world scenarios

## Key kubectl Commands for This Domain

```bash
# Pod creation and management
kubectl run [name] --image=[image] --port=[port] --labels=[labels]
kubectl get pods -o wide --show-labels
kubectl describe pod [name]
kubectl logs [pod-name] -c [container-name]
kubectl exec -it [pod-name] -- [command]

# Jobs and CronJobs
kubectl create job [name] --image=[image] -- [command]
kubectl create cronjob [name] --image=[image] --schedule="[cron]" -- [command]
kubectl get jobs
kubectl get cronjobs

# Container and image operations
kubectl get pods [name] -o jsonpath='{.spec.containers[*].image}'
kubectl set image pod/[name] [container]=[image]
```

## Common Patterns and Tips

### Pod Design Best Practices
- Use appropriate restart policies
- Set resource requests and limits
- Configure health checks (probes)
- Use proper labels for organization

### Multi-container Patterns
- **Sidecar**: Supporting container (logging, monitoring)
- **Ambassador**: Proxy container (database proxy)
- **Adapter**: Data formatting container (log formatting)

### Container Image Best Practices
- Use specific image tags (not `latest`)
- Minimize image size
- Run as non-root user when possible
- Use multi-stage builds for efficiency

## Troubleshooting Guide

### Common Issues
- **ImagePullBackOff**: Check image name and registry access
- **CrashLoopBackOff**: Examine container logs and configuration
- **Pending**: Check resource availability and node capacity
- **Init containers failing**: Debug init container logs first

### Debugging Commands
```bash
kubectl describe pod [name]           # Check events and status
kubectl logs [name] --previous        # Previous container logs
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top pods                      # Resource usage
```

## Study Resources

- [Kubernetes Pod Documentation](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Jobs Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
- [CronJobs Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [Multi-container Pod Patterns](https://kubernetes.io/blog/2015/06/the-distributed-system-toolkit-patterns/)

---

**Domain Weight**: 20% of CKAD exam  
**Recommended Practice Time**: 4-6 hours  
**Focus Areas**: Pod lifecycle, container patterns, batch processing