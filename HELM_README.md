# Helm Chart for Minecraft Project

This document explains how to use the Helm chart for deploying the Minecraft server system.

## Overview

The Helm chart provides a complete, templated deployment solution for the Minecraft server system, including:
- Proxy server (Velocity/BungeeCord)
- Hub server
- Multiple survival worlds
- Utility services

## Chart Structure

```
helm/
├── Chart.yaml              # Chart metadata
├── values.yaml             # Default values
├── values-dev.yaml         # Development values
├── values-prod.yaml        # Production values
└── templates/
    ├── _helpers.tpl        # Common template functions
    ├── configmap-*.yaml    # ConfigMap templates
    ├── deployment-*.yaml   # Deployment templates
    └── service-*.yaml      # Service templates
```

## Prerequisites

1. **Helm**: Install Helm from [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)
2. **Kubernetes**: A Kubernetes cluster (local or remote)
3. **kubectl**: Configured to work with your cluster

## Quick Start

### Production Deployment

1. **Install the chart**:
   ```bash
   just helm-install
   ```

2. **Check status**:
   ```bash
   just helm-status
   ```

3. **Upgrade the chart**:
   ```bash
   just helm-upgrade
   ```

4. **Uninstall the chart**:
   ```bash
   just helm-uninstall
   ```

### Development Deployment

1. **Start development environment**:
   ```bash
   just dev-helm
   ```

2. **Access Tilt UI**: Open [http://localhost:10350](http://localhost:10350)

## Configuration

### Values Files

The chart uses three values files:

- **`values.yaml`**: Default configuration
- **`values-dev.yaml`**: Development overrides (local images, reduced resources)
- **`values-prod.yaml`**: Production overrides (versioned images, higher resources)

### Key Configuration Options

#### Global Settings
```yaml
global:
  namespace: yicraft
  imageRegistry: ""
  imagePullPolicy: IfNotPresent
  nodeSelector:
    pow: hi
  resources:
    limits:
      memory: "2048Mi"
      cpu: "500m"
```

#### Image Configuration
```yaml
images:
  spigot:
    repository: marcstreeter/spigot
    tag: "v28"
  proxy:
    repository: marcstreeter/proxy
    tag: "v10"
  utils:
    repository: marcstreeter/utils
    tag: "v11"
```

#### Service Configuration
```yaml
proxy:
  enabled: true
  replicaCount: 1
  service:
    type: NodePort
    port: 25577
    nodePort: 30565
```

#### Git Configuration
```yaml
proxy:
  git:
    committerName: "Marc Streeter"
    committerEmail: "mstreeter@gmail.com"
    url: "github.com/marcstreeter/minecraft-proxy-saved.git"
    token: "your-git-token"
    user: "marcstreeter"
```

## Available Commands

### Helm Commands
```bash
# Install chart
just helm-install

# Upgrade chart
just helm-upgrade

# Uninstall chart
just helm-uninstall

# Check status
just helm-status

# List releases
just helm-list
```

### Development Commands
```bash
# Start development with Helm and Tilt
just dev-helm

# Start development with legacy Kubernetes manifests
just dev
```

## Customization

### Adding New Survival Worlds

1. **Add world configuration to `values.yaml`**:
   ```yaml
   survival:
     worlds:
       newworld:
         enabled: true
         replicaCount: 1
         service:
           type: NodePort
           port: 25565
         git:
           committerName: "Marc Streeter"
           committerEmail: "mstreeter@gmail.com"
           url: "github.com/marcstreeter/minecraft-newworld-saved.git"
           token: "your-git-token"
           user: "marcstreeter"
   ```

2. **The templates will automatically generate**:
   - ConfigMap for the new world
   - Deployment for the new world
   - Service for the new world

### Modifying Resource Limits

Edit the `global.resources` section in your values file:

```yaml
global:
  resources:
    limits:
      memory: "4096Mi"
      cpu: "1000m"
    requests:
      memory: "2048Mi"
      cpu: "500m"
```

### Changing Image Tags

For production:
```bash
helm upgrade minecraft-project ./helm -n yicraft \
  --set images.spigot.tag=v29 \
  --set images.proxy.tag=v11 \
  --set images.utils.tag=v12
```

For development:
```bash
helm upgrade minecraft-project ./helm -n yicraft \
  --set images.spigot.tag=local \
  --set images.proxy.tag=local \
  --set images.utils.tag=local
```

## Environment-Specific Deployments

### Development Environment
- Uses local image builds
- Reduced resource limits
- No node selectors
- Port forwarding for local access

### Production Environment
- Uses versioned images from registry
- Higher resource limits
- Node selectors for high-power nodes
- Load balancer or ingress for external access

## Troubleshooting

### Common Issues

1. **Chart installation fails**:
   ```bash
   # Check Helm version
   helm version
   
   # Validate chart
   helm lint ./helm
   
   # Dry run installation
   helm install minecraft-project ./helm --dry-run
   ```

2. **Pods not starting**:
   ```bash
   # Check pod status
   kubectl get pods -n yicraft
   
   # Check pod events
   kubectl describe pod <pod-name> -n yicraft
   
   # Check pod logs
   kubectl logs <pod-name> -n yicraft
   ```

3. **Image pull errors**:
   ```bash
   # Check if images exist
   docker pull marcstreeter/spigot:v28
   docker pull marcstreeter/proxy:v10
   docker pull marcstreeter/utils:v11
   ```

### Debugging Commands

```bash
# Get all resources
kubectl get all -n yicraft

# Get Helm release info
helm get all minecraft-project -n yicraft

# Get values used in deployment
helm get values minecraft-project -n yicraft

# Rollback to previous version
helm rollback minecraft-project -n yicraft
```

## Migration from Kubernetes Manifests

If you're migrating from the old Kubernetes manifests:

1. **Backup current deployment**:
   ```bash
   kubectl get all -n yicraft -o yaml > backup.yaml
   ```

2. **Uninstall old deployment**:
   ```bash
   kubectl delete -f kubernetes/
   ```

3. **Install Helm chart**:
   ```bash
   just helm-install
   ```

4. **Verify migration**:
   ```bash
   just helm-status
   kubectl get pods -n yicraft
   ```

## Best Practices

1. **Use values files** for environment-specific configuration
2. **Version your images** and update the chart accordingly
3. **Use secrets** for sensitive data like Git tokens
4. **Monitor resource usage** and adjust limits as needed
5. **Test changes** in development before deploying to production

## Next Steps

1. Configure your Git repositories and tokens
2. Set up monitoring and logging
3. Configure ingress or load balancer for external access
4. Set up automated deployments with CI/CD 