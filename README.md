# Minecraft-Project

This project accompanies the article series on running Minecraft in Docker and
writing Minecraft plugins to integrate with IBM Cloud.
Read the article series at: https://www.ibm.com/developerworks/cloud/library/cl-bluemix-minecraft-docker-trs-1/index.html

## Requirements
- [kubectl]
- [just]
- [jq]
- [curl]
- [awk]
- [sed]

NOTE: many of these can be installed with either [brew] or [asdf]

## Setup

Here are the steps to get your minecraft server going

- create world and commit to repository
- create access tokens[\*](https://support.cloudbees.com/hc/en-us/articles/234710368-GitHub-Permissions-and-API-token-Scopes-for-Jenkins)
- copy `configmap.yml.example` and fill your own details
- `kubectl apply -f kubernetes/configmap.yml`
- `kubectl apply -f kubernetes/deploy.yml`
- Enjoy!

## justfile

This project uses a [justfile](https://github.com/casey/just) for task automation. If you don't have `just` installed, you can install it with:

```bash
brew install just  # macOS
# or see https://github.com/casey/just#installation for other platforms
```

## Setup - nodes

The nodes need to be labeled in order to run as running on raspberry pi's is not optimal for minecraft servers

```
just label
```

## Updating Images

Happens via GitHub Actions!

## Deploy

Bring up your server like so

```
just up
```

## Destroy

Tear down server like so

```
just down
```

## Reset

Can set to a previous saved state in game with `/save` or via api call in `utils` container (TODO put api call here)

### TODO

- smush commits periodically according to max time being stored (give warning that more time means more storage / and longer init times because whole repo must be downloaded)

## Run Locally

### Option 1: Manual Kubernetes Setup

You may run this with a local copy of kubernetes, just (port forward)[https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/] your pod with

```bash
kubectl port-forward <SPIGOT-POD-NAME> 25565:25565
```

and then from within minecraft point to localhost

### Option 2: Helm Chart Deployment (Recommended)

For production and development, use the Helm chart:

1. **Install the Helm chart**:
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

See [HELM_README.md](HELM_README.md) for detailed instructions on using the Helm chart.

### Option 3: Tilt Development Environment

For local development with live updates, use Tilt with Helm:

1. **Start the development environment**:
   ```bash
   just dev-helm
   ```

2. **Access the Tilt UI**: Open [http://localhost:10350](http://localhost:10350) in your browser

See [TILT_README.md](TILT_README.md) for detailed instructions on using Tilt for local development.

# TODO
- need to stop using latest (increment both version and helm chart reference)

[just]: https://github.com/casey/just
[asdf]: https://asdf-vm.com/
[kubectl]: https://kubernetes.io/docs/reference/kubectl/
[brew]: https://brew.sh/
[jq]: https://jqlang.org
[curl]: https://curl.se
[awk]: https://www.gnu.org/software/gawk/manual/gawk.html
[sed]: https://www.gnu.org/software/sed/manual/sed.html
