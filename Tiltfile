# Tiltfile for Minecraft Project with Helm
allow_k8s_contexts('docker-desktop')

# Load environment variables
# load('ext://dotenv', 'dotenv')
# dotenv()

# Set namespace
namespace = 'yicraft'

# Create namespace if it doesn't exist
k8s_yaml(encode_yaml({
    'apiVersion': 'v1',
    'kind': 'Namespace',
    'metadata': {
        'name': namespace
    }
}))

# Build and deploy the utility container first (used by other services)
docker_build(
    'marcstreeter/utils:local',
    './util',
    dockerfile='./util/Dockerfile',
    live_update=[
        sync('./util/src', '/app/src'),
        run('pip install -r requirements.txt', trigger=['./util/requirements.txt'])
    ]
)

# Build and deploy the proxy server
docker_build(
    'marcstreeter/proxy:local',
    '.',
    dockerfile='./proxy/Dockerfile',
    live_update=[
        sync('./proxy', '/app/proxy')
    ]
)

# Build and deploy the spigot server
docker_build(
    'marcstreeter/spigot:local',
    '.',
    dockerfile='./server/Dockerfile',
    live_update=[
        sync('./server', '/app/server')
    ]
)

# Deploy using Helm chart
k8s_yaml(helm(
    'manifests',
    values=['manifests/values-dev.yaml']
))
# helm(
#     'minecraft-project',
#     './helm',
#     namespace=namespace,
#     values=['helm/values-dev.yaml'],
#     set=[
#         'images.spigot.tag=local',
#         'images.proxy.tag=local',
#         'images.utils.tag=local',
#         'development.enabled=true',
#         'development.localImages=true'
#     ]
# )

# Configure port forwards for all services
# k8s_resource(
#     'minecraft-project-proxy',
#     resource_deps=['marcstreeter/proxy:local'],
#     port_forwards=[
#         '25577:25577',  # Proxy port
#         '30565:30565'   # NodePort
#     ],
#     labels=['proxy']
# )

# k8s_resource(
#     'minecraft-project-hub',
#     resource_deps=['marcstreeter/spigot:local', 'marcstreeter/utils:local'],
#     port_forwards=[
#         '25565:25565'  # Hub server port
#     ],
#     labels=['hub']
# )

# Configure all survival world servers
survival_servers = [
    'minecraft-project-survival-main',
    'minecraft-project-survival-berry',
    'minecraft-project-survival-ice', 
    'minecraft-project-survival-lily',
    'minecraft-project-survival-sand',
    'minecraft-project-survival-wood'
]

# Assign different ports for each survival server
survival_ports = [
    '25566:25565',  # survival
    '25567:25565',  # berry
    '25568:25565',  # ice
    '25569:25565',  # lily
    '25570:25565',  # sand
    '25571:25565'   # wood
]

# for i, server in enumerate(survival_servers):
#     k8s_resource(
#         server,
#         resource_deps=['marcstreeter/spigot:local', 'marcstreeter/utils:local'],
#         port_forwards=[survival_ports[i]],
#         labels=['survival']
#     )

# Custom resource groups for better organization
# k8s_resource_group(
#     'proxy',
#     ['minecraft-project-proxy'],
#     labels=['proxy']
# )

# k8s_resource_group(
#     'hub',
#     ['minecraft-project-hub'],
#     labels=['hub']
# )

# k8s_resource_group(
#     'survival-worlds',
#     survival_servers,
#     labels=['survival']
# )

# # Add helpful commands
# local_resource(
#     'minecraft-status',
#     'kubectl get pods -n yicraft',
#     resource_deps=['minecraft-project-proxy', 'minecraft-project-hub'] + survival_servers,
#     labels=['status']
# )

# local_resource(
#     'proxy-logs',
#     'kubectl logs -f deployment/minecraft-project-proxy -n yicraft',
#     resource_deps=['minecraft-project-proxy'],
#     labels=['logs']
# )

# local_resource(
#     'hub-logs',
#     'kubectl logs -f deployment/minecraft-project-hub -n yicraft',
#     resource_deps=['minecraft-project-hub'],
#     labels=['logs']
# )

# # Add port forwarding info
# local_resource(
#     'connection-info',
#     'echo "Minecraft Connection Info:" && echo "Proxy: localhost:25577" && echo "Hub: localhost:25565" && echo "Survival: localhost:25566" && echo "Berry: localhost:25567" && echo "Ice: localhost:25568" && echo "Lily: localhost:25569" && echo "Sand: localhost:25570" && echo "Wood: localhost:25571"',
#     labels=['info']
# ) 