# Question 001: Create a Basic Pod

**Difficulty**: Basic  
**Domain**: Application Design and Build  
**Time Limit**: 5 minutes  
**Points**: 4 points

## Scenario

Your development team needs to deploy a simple web application for testing purposes. They want to run a single nginx container that can serve basic web content. As a Kubernetes application developer, you need to create a Pod to host this application.

## Task

Create a Pod that meets the following specifications:

- [ ] Pod name: `web-server`
- [ ] Namespace: `default`
- [ ] Container name: `nginx-container`
- [ ] Container image: `nginx:1.20`
- [ ] Container port: `80`
- [ ] Add labels: `app=web`, `tier=frontend`

## Requirements

- **Namespace**: `default`
- **Resource Names**: Pod must be named exactly `web-server`
- **Labels**: Must include `app=web` and `tier=frontend`
- **Container**: Must use nginx image version 1.20

## Success Criteria

1. **Pod Creation**: Verify the Pod is created and running
   ```bash
   kubectl get pods web-server
   ```

2. **Pod Details**: Check that the Pod has correct configuration
   ```bash
   kubectl describe pod web-server
   ```

3. **Expected Output**: Pod should be in "Running" status with correct labels and container image

## Tips

- You can use `kubectl run` command for quick Pod creation
- Don't forget to add the required labels
- Use `--dry-run=client -o yaml` to generate YAML if needed
- The container port specification helps with service discovery later

## Related Concepts

- Pod lifecycle and states
- Container specifications
- Kubernetes labels and selectors
- kubectl run command
- YAML manifest structure

---

**Time to attempt**: ⏱️ 5 minutes  
**Solution available**: [`./solution/README.md`](./solution/README.md)