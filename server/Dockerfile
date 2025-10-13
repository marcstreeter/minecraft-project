# to check for latest version run "just check-docker"
FROM eclipse-temurin:21.0.8_9-jdk-noble
RUN mkdir -p /srv/minecraft
WORKDIR /srv/minecraft
# to check for the latest version run "just check-server"
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/paper/versions/1.21.10/builds/69/downloads/paper-1.21.10-69.jar -O paper.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
EXPOSE 25565
CMD ["java","-Xms512M","-Xmx2048M","-Dcom.mojang.eula.agree=true","-Dfile.encoding=UTF-8","-jar","paper.jar","nogui"]