#######################################################################
# IMPORTANT: This is just one Dockerfile varient in a build sequence! #
#                                                                     #
#   Dockerfiles for each distribution can be viewed on GitHub:        #
#   https://github.com/binarybabel/docker-jdk/tree/master/src         #
#                                                                     #
#######################################################################

FROM debian:stable-slim
MAINTAINER BinaryBabel OSS <oss@binarybabel.org>

RUN apt-get update && apt-get install -y curl && apt-get clean

ENV JAVA_DOWNLOAD=http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz
RUN mkdir -p /opt && curl -jfksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
      "${JAVA_DOWNLOAD:-$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk8.txt?p=download_links.tgz)}" \
      | tar -xzf - -C /opt \
    && ln -s /opt/jdk1.*.0_* /opt/jdk \
    && rm -rf /opt/jdk/*src.zip \
              /opt/jdk/lib/missioncontrol \
              /opt/jdk/lib/visualvm \
              /opt/jdk/lib/*javafx* \
              /opt/jdk/jre/lib/plugin.jar \
              /opt/jdk/jre/lib/ext/jfxrt.jar \
              /opt/jdk/jre/bin/javaws \
              /opt/jdk/jre/lib/javaws.jar \
              /opt/jdk/jre/lib/desktop \
              /opt/jdk/jre/plugin \
              /opt/jdk/jre/lib/deploy* \
              /opt/jdk/jre/lib/*javafx* \
              /opt/jdk/jre/lib/*jfx* \
              /opt/jdk/jre/lib/amd64/libdecora_sse.so \
              /opt/jdk/jre/lib/amd64/libprism_*.so \
              /opt/jdk/jre/lib/amd64/libfxplugins.so \
              /opt/jdk/jre/lib/amd64/libglass.so \
              /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
              /opt/jdk/jre/lib/amd64/libjavafx*.so \
              /opt/jdk/jre/lib/amd64/libjfx*.so

ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

COPY java.sh /usr/bin/java
RUN chmod 755 /usr/bin/java
ENTRYPOINT ["/usr/bin/java"]
CMD ["-version"]
WORKDIR /srv
