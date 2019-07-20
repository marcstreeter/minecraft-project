# Version 0.0.4
# This version builds a spigot server
# using the recommended build strategy for spigot
# This is advantageous in that it’s better for plugin development
# and fits well with the Docker approach
# it also adds a first Minecraft plugin into the bare spigot server
#
FROM openjdk:8u212-b04-jdk-stretch
RUN mkdir -p /srv/minecraft
WORKDIR /srv/minecraft
RUN apt-get update &&\
	apt-get install -y git &&\
	apt-get install -y wget &&\
	mkdir spigot &&\
	wget "https://hub.spigotmc.org//jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -O spigot/BuildTools.jar &&\
	git config --global core.autocrlf input &&\
	java -Xmx1024M -jar spigot/BuildTools.jar --rev 1.14.3 &&\
	rm -r Bukkit &&\
	rm -r CraftBukkit &&\
	rm -r Spigot &&\
	rm -r BuildData &&\
	rm -r work &&\
	rm -r spigot &&\
	apt-get purge -y --autoremove git wget
RUN echo "eula=true" > eula.txt &&\
	mkdir plugins
ADD Tutorial.jar /plugins/Tutorial.jar
CMD java -Xms1024m -Xmx2048m -jar spigot-1.14.3.jar nogui
EXPOSE 25565
