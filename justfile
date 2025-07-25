# Variables
KUBE_CONTEXT := "local"
NAMESPACE := "yicraft"
HIGH_POWER_NODES := "k3sruth k3sluke k3sjane k3snena k3sjose server-mini-b server-mini-c server-mini-d"

# Check if tilt is installed
_check-tilt:
    which tilt > /dev/null || (echo "tilt is not installed, install from https://docs.tilt.dev/install.html"; exit 1)

# Check if helm is installed
_check-helm:
    which helm > /dev/null || (echo "helm is not installed, install from https://helm.sh/docs/intro/install/"; exit 1)

# Helper recipes
check-curl:
    which curl > /dev/null || (echo "curl is not installed, in what world do you live in?"; exit 1)

check-jq:
    which jq > /dev/null || (echo "jq is not installed, use 'brew install jq' to proceed."; exit 1)

with-ctx context="{{KUBE_CONTEXT}}":
    kubectl config use-context {{context}}

with-ns: with-ctx
    #!/usr/bin/env bash
    if echo "$(kubectl get ns -o=name --no-headers)" | grep -q {{NAMESPACE}}; then 
        echo "Namespace '{{NAMESPACE}}' exists."
    else 
        echo "Namespace '{{NAMESPACE}}' does not exist. Creating..."
        kubectl create ns {{NAMESPACE}};
    fi

label: with-ctx
    for node in {{HIGH_POWER_NODES}}; do \
        kubectl label nodes "${node}" pow=hi; \
    done

up: with-ns
    kubectl -n {{NAMESPACE}} apply -f kubernetes/

down: with-ns
    kubectl -n {{NAMESPACE}} delete -f kubernetes/

check-server: check-jq check-curl
    curl -s https://api.papermc.io/v2/projects/paper/ \
        | jq '.versions | .[-3:]' \
        | jq  --raw-output '.[]' \
        | xargs -I {} curl -s "https://api.papermc.io/v2/projects/paper/versions/{}/builds/" \
        | jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

check-proxy: check-jq check-curl
    curl -s https://api.papermc.io/v2/projects/velocity/ \
        | jq '.versions | .[-3:]' \
        | jq  --raw-output '.[]' \
        | xargs -I {} curl -s "https://api.papermc.io/v2/projects/velocity/versions/{}/builds/" \
        | jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

check-docker: check-jq check-curl
    curl -s "https://hub.docker.com/v2/repositories/library/eclipse-temurin/tags/?page_size=25&page=1&name=jdk&ordering" \
    | jq -r '.results[] | select(.name | test("^[0-9]+(\\.[0-9]+(\\.[0-9]+)?)?(_[0-9]+)?-jdk(-[a-z]+)?$")) | .name' \
    | head -10

get-docker-token *IMAGE:
    @curl --silent "https://auth.docker.io/token?service=registry.docker.io&scope=repository:{{IMAGE}}:pull" | jq -r '.token'

get-latest-server-version *IMAGE:
    @latest=$(curl --silent --header "Authorization: Bearer $(just get-docker-token {{IMAGE}})" "https://registry-1.docker.io/v2/{{IMAGE}}/tags/list" | jq -r '.tags[] | select(test("^v[0-9]+$"))' | sort -V | tail -1); \
    echo ${latest}

increment-version *version:
    new_version="v$(echo "{{version}}" | sed 's/v//' | awk '{print $1 + 1}')"; \
    echo $new_version

build-server *IMAGE:
    latest_version=$(just get-latest-server-version {{IMAGE}}); \
    new_version=$(just increment-version $latest_version); \
    docker build -t {{IMAGE}}:$new_version -f server/Dockerfile .; \
    docker tag {{IMAGE}}:$new_version {{IMAGE}}:latest; \
    echo "{{IMAGE}} server build complete - version $new_version"

build:
    just build-server marcstreeter/spigot
    just build-server marcstreeter/proxy
    echo "both builds complete"

dev: 
    just with-ctx docker-desktop
    tilt up

# Show available commands
default:
    @just --list