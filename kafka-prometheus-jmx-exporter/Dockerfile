FROM openjdk:8u131-jre-alpine

ENV EXPORTER_VERSION=8ded2c5e112f8c458e60398c528799ca763c78ac

RUN set -e; cd /usr/local; \
  MAVEN_VERSION=3.5.0 PATH=$PATH:$(pwd)/maven/bin; \
  apk add  --no-cache --virtual .build-deps \
    curl \
    openjdk8="$JAVA_ALPINE_VERSION"; \
  mkdir ./maven; \
  curl -SLs https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - --strip-components=1 -C ./maven; \
  mvn --version; \
  \
  mkdir ./jmx_exporter; \
  curl -SLs https://github.com/prometheus/jmx_exporter/archive/$EXPORTER_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./jmx_exporter; \
  cd ./jmx_exporter; \
  mvn package; \
  \
  rm /root/.m2 -Rf; \
  apk del .build-deps;

RUN apk add --no-cache bash

WORKDIR /usr/local/jmx_exporter
ENTRYPOINT ["run_sample_httpserver.sh"]
