# Oracle JDK Docker Base Images

[![Build Status](https://travis-ci.org/binarybabel/docker-jdk.svg?branch=master)](https://travis-ci.org/binarybabel/docker-jdk) [![GitHub release](https://img.shields.io/github/tag/binarybabel/docker-jdk.svg)](https://hub.docker.com/r/binarybabel/oracle-jdk/tags/) **— Images are built automatically from the latest [Oracle Downloads](http://www.oracle.com/technetwork/java/javase/downloads/)**

**_Docker project maintained by BinaryBabel — Not an official Oracle product release._**

Available for **Java 7/8**, review [Docker Hub Tags](https://hub.docker.com/r/binarybabel/oracle-jdk/tags/) for all current releases.

| Docker Hub Tag (JDK8) | Base Image | `JAVA_HOME` | Working Dir | ~Size  |
| ----------------------- | ---------- | ----------- | ----------- | :---: |
| `8-alpine` _[-Dockerfile](https://github.com/binarybabel/docker-jdk/blob/master/src/alpine.Dockerfile)_ | [alpine:latest](https://hub.docker.com/_/alpine/) | `/opt/jdk/bin/java/` | `/srv/` | 70mb |
| `8-centos` _[-Dockerfile](https://github.com/binarybabel/docker-jdk/blob/master/src/centos.Dockerfile)_ | [centos:7](https://hub.docker.com/_/centos/) | `/usr/bin/java/` | `/srv/` | 260mb |
| `8-debian` _[-Dockerfile](https://github.com/binarybabel/docker-jdk/blob/master/src/debian.Dockerfile)_ | [debian:stable-slim](https://hub.docker.com/_/debian/) | `/opt/jdk/bin/java/` | `/srv/` | 100mb |

These images are rebuilt when new versions of Java are released, through the use of webhooks provided by the [Latestver](https://lv.binarybabel.org) dependency tracking tool, a [BinaryBabel OSS Project](https://github.com/binarybabel/latestver).

|  JDK  | Current Version |  JDK  | Current Version |
| :---: | :-------------: | :---: | :-------------: |
| `8` | [![Latestver](https://lv.binarybabel.org/catalog-api/java/jdk8.svg?v=8u144-b01)](https://lv.binarybabel.org/catalog/java/jdk8) | `7` | [![Latestver](https://lv.binarybabel.org/catalog-api/java/jdk7.svg)](https://lv.binarybabel.org/catalog/java/jdk7) |

_NOTE: JDK7 updates are no longer being provided publicly by Oracle._

**Usage of Oracle Java is subject to acceptance of Oracle's [Binary Code License Agreement](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) (BCLA).**

  + The environment variable `ACCEPT_ORACLE_BCLA` must be set. _Examples are given below._
  + **"Creating a Docker image"** example explains accepting BCLA as part of a dependent image.
    - **BCLA §C** describes distributing Oracle Java, "for the sole purpose of running your Programs"
  + By using the Java binaries in any manner you are accepting the Oracle BCLA.

## Container Usage Examples

The entry-point for each container is the `java` command, by default.  
So additional docker command line options become Java options.

#### Print Containerized Java Version

    docker run --rm -e ACCEPT_ORACLE_BCLA=true binarybabel/jdk:8-alpine -version

#### Using Compose to run a JAR

**`docker-compose.yml`**

    version: '2'
    services:
      app:
        image: 'binarybabel/jdk:8-alpine'
        environment:
          - ACCEPT_ORACLE_BCLA=true
        volumes:
          - /path/to/some/local/file.jar:/srv/app.jar:ro
        command: [-jar, app.jar]

#### Creating a Docker image / Redistribution

**`Dockerfile`**

    FROM binarybabel/jdk:8-alpine

    # ------------------------------------------------------
    # Accept the Oracle License for all users of this image,
    # per Section C of the BCLA, permitting Oracle Java:
    #   "(i) ... bundled as part of, and for the
    #    sole purpose of running, your Programs"
    # ------------------------------------------------------
    ENV ACCEPT_ORACLE_BCLA=true

    RUN curl http://example.com/some-java-app.tgz | tar xz

    CMD ["-jar", "some-java-app/app.jar"]

**Building / Running**

By accepting the Oracle BCLA in the Dockerfile, users are not required to set the ENV option.

    $ docker build -t myorg/myapp .
    $ docker run --rm myorg/myapp

## Maintainer & Licenses

                                                                                  0101010
                                                                               0010011
                                                                             110101
                                                                           0011
                                                                                    0100010
        The Dockerfile(s), build mechanics, and documentation          1010    0010101000001
         provided in the source repository are maintained at:         010101110100111101010010
                                                                     01     0011000100
             https://github.com/binarybabel/docker-jdk
                                                                       0100
                                                                    01001001    binarybabel.org
                                                                   0100111001    000001010001110
                                                                  101       0010010000010100100101
                                                              00111          0010011110100011001010
                                                              0110            10000010100111001000100

* Unless otherwise noted, all source-controlled files are released under the [MIT License](https://opensource.org/licenses/MIT).
* When built, this repository generates artifacts that may bundle resources from other licenses:
  * Repository file `THIRDPARTYLICENSEREADME.txt` may contain additional information.
  * To the best of the maintainer's knowledge, any build-time dependencies were released under a license permitting their inclusion in such an open-source build.
