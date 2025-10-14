# Variables
KUBE_CONTEXT := "local"
NAMESPACE := "yicraft"
LONG_LIFE_NODES := "server-mini-b server-mini-c server-mini-d server-mini-e"
HIGH_POWER_NODES := "k3sruth k3sluke k3sjane" # THESE ARE MISSING k3snena k3sjose
# Helper recipes

_check-tilt:
    which tilt > /dev/null || (echo "tilt is not installed, install from https://docs.tilt.dev/install.html"; exit 1)

_check-helm:
    which helm > /dev/null || (echo "helm is not installed, install from https://helm.sh/docs/intro/install/"; exit 1)

@_check-curl:
    which curl > /dev/null || (echo "curl is not installed, in what world do you live in?"; exit 1)

@_check-jq:
    which jq > /dev/null || (echo "jq is not installed, use 'brew install jq' to proceed."; exit 1)

_get-docker-token *IMAGE:
    @curl --silent "https://auth.docker.io/token?service=registry.docker.io&scope=repository:{{IMAGE}}:pull" | jq -r '.token'

_increment-version *version:
    new_version="v$(echo "{{version}}" | sed 's/v//' | awk '{print $1 + 1}')"; \
    echo $new_version

_with-ctx context=KUBE_CONTEXT:
    kubectl config use-context {{context}}

_with-ns: _with-ctx
    #!/usr/bin/env bash
    if echo "$(kubectl get ns -o=name --no-headers)" | grep -q {{NAMESPACE}}; then 
        echo "Namespace '{{NAMESPACE}}' exists."
    else 
        echo "Namespace '{{NAMESPACE}}' does not exist. Creating..."
        kubectl create ns {{NAMESPACE}};
    fi

# appends required labels to target nodes
_label: _with-ctx
    for node in {{LONG_LIFE_NODES}}; do \
        kubectl label nodes "${node}" pow=hi; \
    done

# removes labels from target nodes
_unlabel: _with-ctx
    for node in {{LONG_LIFE_NODES}}; do \
        kubectl label nodes "${node}" pow-; \
    done

# brings up your minecraft cluster (opposite of down)
up: _check-helm _with-ns _label
    # Load .env file and apply with Helm
    export $(grep -v '^#' .env | grep -v '^$' | xargs) && \
    helm template minecraft-project ./manifests --namespace {{NAMESPACE}} -f ./manifests/values-prod.yaml \
        --set global.git.committerName="${GIT_COMMITTER_NAME:-}" \
        --set global.git.committerEmail="${GIT_COMMITTER_EMAIL:-}" \
        --set global.git.token="${GIT_TOKEN:-}" \
        --set global.git.user="${GIT_USER:-}" \
        --set global.forwardingSecret="${VELOCITY_FORWARDING_SECRET:-}" \
        --set proxy.git.url="${GIT_URL_PROXY:-}" \
        --set hub.git.url="${GIT_URL_HUB:-}" \
        --set survival.worlds.survival.git.url="${GIT_URL_SURVIVAL:-}" \
        --set survival.worlds.survival-berry.git.url="${GIT_URL_SURVIVAL_BERRY:-}" \
        --set survival.worlds.survival-ice.git.url="${GIT_URL_SURVIVAL_ICE:-}" \
        --set survival.worlds.survival-lily.git.url="${GIT_URL_SURVIVAL_LILY:-}" \
        --set survival.worlds.survival-sand.git.url="${GIT_URL_SURVIVAL_SAND:-}" \
        --set survival.worlds.survival-wood.git.url="${GIT_URL_SURVIVAL_WOOD:-}" | kubectl apply -f -

# tears down your minecraft cluster (opposite of up)
down: _with-ns _unlabel
    # Load .env file and delete with Helm
    export $(grep -v '^#' .env | grep -v '^$' | xargs) && \
    helm template minecraft-project ./manifests --namespace {{NAMESPACE}} -f ./manifests/values-prod.yaml \
        --set global.git.committerName="${GIT_COMMITTER_NAME:-}" \
        --set global.git.committerEmail="${GIT_COMMITTER_EMAIL:-}" \
        --set global.git.token="${GIT_TOKEN:-}" \
        --set global.git.user="${GIT_USER:-}" \
        --set global.forwardingSecret="${VELOCITY_FORWARDING_SECRET:-}" \
        --set proxy.git.url="${GIT_URL_PROXY:-}" \
        --set hub.git.url="${GIT_URL_HUB:-}" \
        --set survival.worlds.survival.git.url="${GIT_URL_SURVIVAL:-}" \
        --set survival.worlds.survival-berry.git.url="${GIT_URL_SURVIVAL_BERRY:-}" \
        --set survival.worlds.survival-ice.git.url="${GIT_URL_SURVIVAL_ICE:-}" \
        --set survival.worlds.survival-lily.git.url="${GIT_URL_SURVIVAL_LILY:-}" \
        --set survival.worlds.survival-sand.git.url="${GIT_URL_SURVIVAL_SAND:-}" \
        --set survival.worlds.survival-wood.git.url="${GIT_URL_SURVIVAL_WOOD:-}" | kubectl delete -f -

# check for current minecraft server version
check-server: _check-jq _check-curl
    curl -s https://api.papermc.io/v2/projects/paper/ \
        | jq '.versions | .[-3:]' \
        | jq  --raw-output '.[]' \
        | xargs -I {} curl -s "https://api.papermc.io/v2/projects/paper/versions/{}/builds/" \
        | jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

# check for current base proxy image
check-proxy: _check-jq _check-curl
    curl -s https://api.papermc.io/v2/projects/velocity/ \
        | jq '.versions | .[-3:]' \
        | jq  --raw-output '.[]' \
        | xargs -I {} curl -s "https://api.papermc.io/v2/projects/velocity/versions/{}/builds/" \
        | jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

# check for current base hub/world image
check-docker: _check-jq _check-curl
    curl -s "https://hub.docker.com/v2/repositories/library/eclipse-temurin/tags/?page_size=25&page=1&name=jdk&ordering" \
    | jq -r '.results[] | select(.name | test("^[0-9]+(\\.[0-9]+(\\.[0-9]+)?)?(_[0-9]+)?-jdk(-[a-z]+)?$")) | .name' \
    | head -10

# helper for github action: determines current version for target IMAGE (e.g `just get-current-image-version marcstreeter/utils`)
@get-current-image-version *IMAGE: _check-curl _check-jq
    latest=$(curl --silent --header "Authorization: Bearer $(just _get-docker-token {{IMAGE}})" "https://registry-1.docker.io/v2/{{IMAGE}}/tags/list" | jq -r '.tags[] | select(test("^v[0-9]+$"))' | sort -V | tail -1); \
    echo ${latest}

# helper for github action: determines next logical version for target IMAGE (e.g `just get-next-image-version marcstreeter/spigot`)
@get-next-image-version *IMAGE:
    latest_version=$(just get-current-image-version {{IMAGE}} 2>/dev/null); \
    next_version=$(just _increment-version $latest_version 2>/dev/null); \
    echo $next_version

# deprecated specific local build command (building happens in github action now)
build-server *IMAGE:
    new_version=$(just get-next-version {{IMAGE}}); \
    docker build -t {{IMAGE}}:$new_version -f server/Dockerfile .; \
    docker tag {{IMAGE}}:$new_version {{IMAGE}}:latest; \
    echo "{{IMAGE}} server build complete - version $new_version"

# deprecated general local build command (building happens in github action now)
build:
    just build-server marcstreeter/spigot
    just build-server marcstreeter/proxy
    echo "both builds complete"

# brings up cluster on your local device (opposite of dev-down)
dev-up: _check-tilt
    just _with-ctx docker-desktop
    tilt up

# tears down cluster on your local device (opposite of dev-up)
dev-down: _check-tilt
    just _with-ctx docker-desktop
    tilt down