# Question 001: Create and Use ConfigMap

**Difficulty**: Basic  
**Domain**: Application Environment, Configuration and Security  
**Time Limit**: 8 minutes  
**Points**: 6 points

## Scenario

Your application development team needs to externalize configuration data for a web application. The application requires database connection information and feature flags that should be configurable without rebuilding the container image. You need to create a ConfigMap to store this configuration data.

## Task

Create a ConfigMap and use it in a Pod with the following specifications:

- [ ] ConfigMap name: `app-config`
- [ ] Namespace: `default`
- [ ] ConfigMap data:
  - `database_url`: `postgresql://db.example.com:5432/appdb`
  - `debug_mode`: `true`
  - `max_connections`: `100`
- [ ] Pod name: `config-consumer`
- [ ] Pod image: `nginx:1.20`
- [ ] Mount ConfigMap as environment variables in the Pod
- [ ] Verify the environment variables are accessible in the container

## Requirements

- **Namespace**: `default`
- **Resource Names**: ConfigMap `app-config`, Pod `config-consumer`
- **Environment Variables**: All ConfigMap keys should be available as environment variables
- **Verification**: Must be able to see the environment variables inside the container

## Success Criteria

1. **ConfigMap Creation**: Verify ConfigMap exists with correct data
   ```bash
   kubectl get configmap app-config
   kubectl describe configmap app-config
   ```

2. **Pod Creation**: Verify Pod is running and has access to ConfigMap
   ```bash
   kubectl get pod config-consumer
   kubectl describe pod config-consumer
   ```

3. **Environment Variables**: Verify environment variables are set correctly
   ```bash
   kubectl exec config-consumer -- env | grep -E "(database_url|debug_mode|max_connections)"
   ```

## Tips

- Use `kubectl create configmap` for quick creation
- Remember to reference the ConfigMap in the Pod spec using `envFrom`
- You can use `--from-literal` flag to add key-value pairs directly
- Test environment variable access with `kubectl exec`

## Related Concepts

- ConfigMap creation and management
- Environment variable injection
- Pod configuration with external data
- Configuration externalization patterns

---

**Time to attempt**: ⏱️ 8 minutes  
**Solution available**: [`./solution/README.md`](./solution/README.md)