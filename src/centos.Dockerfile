#######################################################################
# IMPORTANT: This is just one Dockerfile varient in a build sequence! #
#                                                                     #
#   Dockerfiles for each distribution can be viewed on GitHub:        #
#   https://github.com/binarybabel/docker-jdk/tree/master/src         #
#                                                                     #
#######################################################################

FROM centos:7
MAINTAINER BinaryBabel OSS <oss@binarybabel.org>

ENV JAVA_DOWNLOAD=
RUN cd /tmp \
    && curl -o jdk.rpm -jfksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
       "${JAVA_DOWNLOAD:-$(curl -s https://lv.binarybabel.org/catalog-api/java/jdk8.txt?p=downloads.rpm)}" \
    && rpm -Uvh jdk.rpm && rm jdk.rpm \
    && echo "export JAVA_HOME=/usr/java/default/" > /etc/profile.d/java_home.sh

COPY java.sh /usr/bin/java
RUN chmod 755 /usr/bin/java
ENTRYPOINT ["/usr/bin/java"]
CMD ["-version"]
WORKDIR /srv
