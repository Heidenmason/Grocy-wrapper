# minimal Docker image based on Alpine Linux with a complete package index
## x86-64
#FROM lscr.io/linuxserver/grocy:amd64-latest

#arm64
FROM lscr.io/linuxserver/grocy:arm64v8-latest

#armhf
#FROM lscr.io/linuxserver/grocy:arm32v7-latest

RUN apk update
#RUN apk add --no-cache tini curl

RUN wget https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_arm.tar.gz -O - |\
    tar xz && mv yq_linux_arm /usr/bin/yq

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
ADD ./check-web.sh /usr/local/bin/check-web.sh
RUN chmod +x /usr/local/bin/check-web.sh
#ADD ./check-user-signups-off.sh /usr/local/bin/check-user-signups-off.sh
#RUN chmod +x /usr/local/bin/check-user-signups-off.sh

# add new packages or upgrade packages to the running system
#RUN \
    # update the index of available packages
    #apk update \
    #echo "updating something"
     
# add local files
#COPY root/ /

# ports and volumes
#EXPOSE 80 443
#VOLUME /config

# C standard library
#ADD ./grocy/target/aarch64-unknown-linux-musl/release/grocy /usr/local/bin/grocy
# Dockerfile directive or instruction that is used to specify the executable which should run when a container is started
#ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
#Change file permission, ensure executable.
#RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
# check if a website is up or down
#ADD ./check-web.sh /usr/local/bin/check-web.sh
#RUN chmod +x /usr/local/bin/check-web.sh

#WORKDIR /root

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]