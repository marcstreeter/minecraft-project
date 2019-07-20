# Minecraft-Project
This project accompanies the article series on running Minecraft in Docker and
writing Minecraft plugins to integrate with IBM Cloud. 
Read the article series at: https://www.ibm.com/developerworks/cloud/library/cl-bluemix-minecraft-docker-trs-1/index.html


## Updating Images
Make changes and then create tag, here we do util image for example

```bash
cd util
docker build . -t <USERNAME>/<IMAGENAME>:<VERSION>
```

then we push up changes

```bash
docker push <TAG-JUST-SET>
```
## Deploy
Bring up your server like so

```
kubectl apply -f deploy.yml
```

For now this project expects that you apply a label to one of your nodes (it doesn't yet perform without taking into consideration the node it's currently running on)

```
kubectl label nodes <your-node-name> special=minecraft
```
