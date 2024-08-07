FROM eclipse-temurin:21.0.3_9-jdk-jammy
RUN mkdir -p /srv/waterfall
WORKDIR /srv/waterfall
RUN apt-get update \
  && apt-get -y install wget \
  && wget https://api.papermc.io/v2/projects/waterfall/versions/1.21/builds/579/downloads/waterfall-1.21-579.jar -O waterfall.jar \
  && apt-get -y remove wget \
  && apt-get -y autoremove --purge
CMD ["java","-Xms512M","-Xmx2048M","-jar","waterfall.jar"]
EXPOSE 25577