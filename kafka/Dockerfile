FROM curlimages/curl@sha256:aa45e9d93122a3cfdf8d7de272e2798ea63733eeee6d06bd2ee4f2f8c4027d7c \
  as extralibs

USER root
RUN curl -sLS -o /zookeeper-3.5.8.jar https://repo1.maven.org/maven2/org/apache/zookeeper/zookeeper/3.5.8/zookeeper-3.5.8.jar
RUN curl -sLS -o /zookeeper-jute-3.5.8.jar https://repo1.maven.org/maven2/org/apache/zookeeper/zookeeper-jute/3.5.8/zookeeper-jute-3.5.8.jar

FROM adoptopenjdk:11.0.7_10-jre-hotspot-bionic@sha256:a119e89693cfca250cecc3756c5efb5fdf523d93d813003b3c2a1d29d8884211

ENV KAFKA_VERSION=2.5.0 SCALA_VERSION=2.12

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='ca-certificates netcat-openbsd'; \
  buildDeps='curl gnupg dirmngr'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -sLS -o KEYS https://www.apache.org/dist/kafka/KEYS; \
  gpg --import KEYS && rm KEYS; \
  \
  SCALA_BINARY_VERSION=$(echo $SCALA_VERSION | cut -f 1-2 -d '.'); \
  mkdir -p /opt/kafka; \
  curl -sLS -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc https://www.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc; \
  curl -sLS -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz"; \
  gpg --verify kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  tar xzf kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz --strip-components=1 -C /opt/kafka; \
  rm kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  \
  rm -rf /opt/kafka/site-docs; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /root/.gnupg

COPY --from=extralibs /zookeeper-3.5.8.jar /opt/kafka/libs/zookeeper-3.5.7.jar
COPY --from=extralibs /zookeeper-jute-3.5.8.jar /opt/kafka/libs/zookeeper-jute-3.5.7.jar

WORKDIR /opt/kafka

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
