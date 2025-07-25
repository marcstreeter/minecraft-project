# to check for latest version run "just check-docker"
FROM eclipse-temurin:21.0.7_6-jdk-noble
RUN mkdir -p /srv/velocity
WORKDIR /srv/velocity
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/velocity/versions/3.4.0-SNAPSHOT/builds/522/downloads/velocity-3.4.0-SNAPSHOT-522.jar -O velocity.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
EXPOSE 25577
CMD ["java","-Xms512M","-Xmx2048M","-jar","velocity.jar"]
