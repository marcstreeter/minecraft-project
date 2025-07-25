# to check for latest version run "just check-docker"
FROM eclipse-temurin:21.0.7_6-jdk-noble
RUN mkdir -p /srv/minecraft
WORKDIR /srv/minecraft
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/paper/versions/1.21.8/builds/11/downloads/paper-1.21.8-11.jar -O paper.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
EXPOSE 25565
CMD ["java","-Xms512M","-Xmx2048M","-Dcom.mojang.eula.agree=true","-Dfile.encoding=UTF-8","-jar","paper.jar","nogui"]
