FROM eclipse-temurin:17.0.7_7-jdk-jammy
RUN mkdir -p /srv/minecraft
WORKDIR /srv/minecraft
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/167/downloads/paper-1.20.1-167.jar -O paper.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
CMD ["java","-Xms512M","-Xmx2048M","-Dcom.mojang.eula.agree=true","-Dfile.encoding=UTF-8","-jar","paper.jar","nogui"]
EXPOSE 25565
