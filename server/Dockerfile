FROM eclipse-temurin:21.0.4_7-jdk-jammy
RUN mkdir -p /srv/minecraft
WORKDIR /srv/minecraft
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/paper/versions/1.21/builds/126/downloads/paper-1.21-126.jar -O paper.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
CMD ["java","-Xms512M","-Xmx2048M","-Dcom.mojang.eula.agree=true","-Dfile.encoding=UTF-8","-jar","paper.jar","nogui"]
EXPOSE 25565
