# Minecraft-Project
This project accompanies the article series on running Minecraft in Docker and
writing Minecraft plugins to integrate with IBM Cloud. 
Read the article series at: https://www.ibm.com/developerworks/cloud/library/cl-bluemix-minecraft-docker-trs-1/index.html

## Setup
Here are the steps to get your minecraft server going
- create world and commit to repository
- create access tokens[*](https://support.cloudbees.com/hc/en-us/articles/234710368-GitHub-Permissions-and-API-token-Scopes-for-Jenkins)
- copy `configmap.yml.example` and fill your own details
- `kubectl apply -f kubernetes/configmap.yml`
- `kubectl apply -f kubernetes/deploy.yml`
- Enjoy!
## Updating Images
Test your image before publishing it

```bash
cd util 
docker build -f Dockerfile.amd64 . -t minecraftutils
docker run -e FLASK_ENV=development -it --rm -p 5000:5000 -v "$(pwd)/src:/srv/utils" minecraftutils sh
$ python -m flask run -h 0.0.0.0 -p 5000
```

Use guilder to build and publish multiarch images

```bash
cd util
guilder build utils --version 6 
cd ../server
guilder build spigot --version 14
cd ../proxy
guilder build spigot-proxy --version  v2
```

## Deploy
Bring up your server like so

```
kubectl apply -f kubernetes/deploy.yml
```

## Reset

Can set to a previous saved state

(TODO make this done via an API call)

### TODO

- smush commits periodically according to max time being stored (give warning that more time means more storage / and longer init times because whole repo must be downloaded)

## Run Locally
You may run this with a local copy of kubernetes, just (port forward)[https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/] your pod with

```bash
kubectl port-forward <SPIGOT-POD-NAME> 25565:25565
```
and then from within minecraft point to localhost

