# syntax=docker/dockerfile:1

FROM openjdk:8u312-jdk-buster

LABEL version="1.2.0"

RUN apt-get update && apt-get install -y curl dos2unix && \
 addgroup minecraft && \
 adduser --home /data --ingroup minecraft --disabled-password minecraft

COPY launch.sh /launch.sh
RUN dos2unix /launch.sh
RUN chmod +x /launch.sh

COPY server /server

USER minecraft

VOLUME /backup
VOLUME /data

WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]

ENV MOTD "Vault Hunters 1.12.4 Modded Minecraft Server Powered by Docker"
# ENV LEVEL "Vault-Hunters" - default
# ENV LEVEL "Iskall-world" - loads Iskall's pre-generated world
ENV JVM_OPTS "-Xms2048m -Xmx6144m"
