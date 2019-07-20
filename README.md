# minecraft-project
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