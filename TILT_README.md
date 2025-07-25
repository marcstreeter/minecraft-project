# Tilt Development Setup

This document explains how to use Tilt for local development of the Minecraft server system.

## Prerequisites

1. **Tilt**: Install Tilt from [https://docs.tilt.dev/install.html](https://docs.tilt.dev/install.html)
2. **Kubernetes**: A local Kubernetes cluster (Docker Desktop, Minikube, or Kind)
3. **kubectl**: Configured to work with your local cluster
4. **Docker**: For building container images

## Quick Start

1. **Setup the development environment**:
   ```bash
   just setup-dev
   ```

2. **Start the development environment**:
   ```bash
   just dev
   ```

3. **Access the Tilt UI**: Open [http://localhost:10350](http://localhost:10350) in your browser

## What Gets Deployed

The Tiltfile orchestrates the following components:

### Core Services
- **Proxy Server** (Velocity/BungeeCord): Routes players between servers
- **Hub Server**: Main lobby/waiting area
- **Utility Container**: Manages world saves and Git operations

### Survival Worlds
- **Survival**: Main survival world
- **Berry**: Berry-themed survival world
- **Ice**: Ice-themed survival world
- **Lily**: Lily-themed survival world
- **Sand**: Sand-themed survival world
- **Wood**: Wood-themed survival world

## Port Mapping

| Service | Port | Description |
|---------|------|-------------|
| Proxy | 25577 | Main proxy server |
| Hub | 25565 | Hub/lobby server |
| Survival | 25566 | Main survival world |
| Berry | 25567 | Berry survival world |
| Ice | 25568 | Ice survival world |
| Lily | 25569 | Lily survival world |
| Sand | 25570 | Sand survival world |
| Wood | 25571 | Wood survival world |

## Development Workflow

### Making Changes

1. **Code Changes**: Edit files in the `server/`, `proxy/`, or `util/` directories
2. **Live Updates**: Tilt will automatically rebuild and redeploy affected services
3. **Configuration Changes**: Edit files in the `kubernetes/` directory and Tilt will apply them

### Useful Commands

```bash
# Start development environment
just dev

# Stop development environment
just tilt-down

# Check status
just tilt-status

# View logs
kubectl logs -f deployment/spigot-proxy -n yicraft
kubectl logs -f deployment/spigot-hub -n yicraft
kubectl logs -f deployment/spigot-survival -n yicraft

# Port forward for direct access
kubectl port-forward deployment/spigot-proxy 25577:25577 -n yicraft
```

### Resource Groups

The Tilt UI organizes resources into groups:

- **proxy**: Proxy server and related resources
- **hub**: Hub server and related resources
- **survival-worlds**: All survival world servers
- **config**: Configuration maps
- **services**: Kubernetes services
- **status**: Status monitoring commands
- **logs**: Log viewing commands
- **info**: Connection information

## Troubleshooting

### Common Issues

1. **Images not building**: Check Docker is running and you have sufficient disk space
2. **Pods not starting**: Check Kubernetes cluster is running and has sufficient resources
3. **Port conflicts**: Ensure the required ports (25565-25577) are not in use by other applications

### Debugging

1. **Check pod status**:
   ```bash
   kubectl get pods -n yicraft
   ```

2. **View pod logs**:
   ```bash
   kubectl logs <pod-name> -n yicraft
   ```

3. **Describe pod for more details**:
   ```bash
   kubectl describe pod <pod-name> -n yicraft
   ```

### Resource Requirements

For local development, ensure your Kubernetes cluster has:
- At least 4GB RAM available
- At least 2 CPU cores
- Sufficient disk space for container images and world data

## Configuration

### Environment Variables

Create a `.env` file in the project root for environment-specific configuration:

```bash
# Example .env file
KUBE_CONTEXT=local
NAMESPACE=yicraft
```

### Customizing Ports

To change the port mappings, edit the `Tiltfile` and update the `port_forwards` sections.

### Adding New Worlds

To add a new survival world:

1. Create a new deployment file in `kubernetes/`
2. Add the server to the `survival_servers` list in the `Tiltfile`
3. Assign a new port in the `survival_ports` list
4. Update the resource configuration

## Production vs Development

- **Development**: Uses `:local` image tags and local builds
- **Production**: Uses versioned image tags (e.g., `:v28`) from Docker Hub

To switch back to production images, run:
```bash
git checkout kubernetes/
```

## Next Steps

1. Configure your configmaps with proper Git repository URLs and tokens
2. Set up your Minecraft client to connect to `localhost:25577`
3. Enjoy developing your Minecraft server system locally! 