# Tiltfile for Minecraft Project with Helm
allow_k8s_contexts('docker-desktop')
load('ext://dotenv', 'dotenv')

# CONSTANTS
DOTENV = dotenv() or {}
SYSENV = dict(os.environ)
NAMESPACE = 'yicraft'

# FUNCTIONS: we should move these to their own repo https://docs.tilt.dev/extensions.html#managing-your-own-extension-repo
def get_env_var(key, default=""):
    """Get environment variable with priority: dotenv > system env > gcloud secrets > default"""
    if key in DOTENV:  # Try dotenv first (if .env file exists)
        return DOTENV[key]
    
    if key in SYSENV:  # Try system environment variable
        return SYSENV[key]
    
    return default

# Create namespace if it doesn't exist
k8s_yaml(encode_yaml({
    'apiVersion': 'v1',
    'kind': 'Namespace',
    'metadata': {
        'name': NAMESPACE
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

# Build and deploy the proxy server with local files
docker_build(
    'marcstreeter/proxy:local',
    '../minecraft-proxy-saved',
    dockerfile='../minecraft-proxy-saved/Dockerfile',
    live_update=[
        sync('../minecraft-proxy-saved', '/srv/velocity')
    ]
)

# Build and deploy the hub server with local files
docker_build(
    'marcstreeter/spigot:hub-local',
    '../minecraft-hub-saved',
    dockerfile='../minecraft-hub-saved/Dockerfile',
    live_update=[
        sync('../minecraft-hub-saved', '/srv/minecraft')
    ]
)

# Build separate images for each survival world with their specific files
docker_build(
    'marcstreeter/spigot:survival-local',
    '../minecraft-survival-saved',
    dockerfile='../minecraft-survival-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-saved', '/srv/minecraft')
    ]
)

docker_build(
    'marcstreeter/spigot:survival-berry-local',
    '../minecraft-survival-berry-saved',
    dockerfile='../minecraft-survival-berry-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-berry-saved', '/srv/minecraft')
    ]
)

docker_build(
    'marcstreeter/spigot:survival-ice-local',
    '../minecraft-survival-ice-saved',
    dockerfile='../minecraft-survival-ice-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-ice-saved', '/srv/minecraft')
    ]
)

docker_build(
    'marcstreeter/spigot:survival-lily-local',
    '../minecraft-survival-lily-saved',
    dockerfile='../minecraft-survival-lily-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-lily-saved', '/srv/minecraft')
    ]
)

docker_build(
    'marcstreeter/spigot:survival-sand-local',
    '../minecraft-survival-sand-saved',
    dockerfile='../minecraft-survival-sand-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-sand-saved', '/srv/minecraft')
    ]
)

docker_build(
    'marcstreeter/spigot:survival-wood-local',
    '../minecraft-survival-wood-saved',
    dockerfile='../minecraft-survival-wood-saved/Dockerfile',
    live_update=[
        sync('../minecraft-survival-wood-saved', '/srv/minecraft')
    ]
)

# Deploy using Helm chart with environment variable substitution
k8s_yaml(helm(
    'manifests',
    values=['manifests/values-dev.yaml'],
    set=[
        # Global Git configuration
        'global.git.committerName={}'.format(get_env_var('GIT_COMMITTER_NAME', '')),
        'global.git.committerEmail={}'.format(get_env_var('GIT_COMMITTER_EMAIL', '')),
        'global.forwardingSecret={}'.format(get_env_var('VELOCITY_FORWARDING_SECRET', '')),
        'global.git.token={}'.format(get_env_var('GIT_TOKEN', '')),
        'global.git.user={}'.format(get_env_var('GIT_USER', '')),
        # Repository URLs
        'proxy.git.url={}'.format(get_env_var('GIT_URL_PROXY', '')),
        'hub.git.url={}'.format(get_env_var('GIT_URL_HUB', '')),
        'survival.worlds.survival.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_MAIN', '')),
        'survival.worlds.survival-berry.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_BERRY', '')),
        'survival.worlds.survival-ice.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_ICE', '')),
        'survival.worlds.survival-lily.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_LILY', '')),
        'survival.worlds.survival-sand.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_SAND', '')),
        'survival.worlds.survival-wood.git.url={}'.format(get_env_var('GIT_URL_SURVIVAL_WOOD', ''))
    ]
))
# helm(
#     'minecraft-project',
#     './helm',
#     namespace=NAMESPACE,
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