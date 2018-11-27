# The only assumption we make about this FROM is that it has a JRE in path
FROM solsson/jdk-opensource:11.0.1@sha256:740feb6c1ecbdf2beac1dc41405c3215511b90d83a7211f805e88f92946dd2a9

ENV KAFKA_VERSION=2.1.0 SCALA_VERSION=2.12 RELEASE_MANAGER_KEY=BEED4F6CB9F77D0E

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='netcat-openbsd'; \
  buildDeps='curl ca-certificates gnupg dirmngr'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  gpg --keyserver pgpkeys.mit.edu --recv-key $RELEASE_MANAGER_KEY; \
  \
  SCALA_BINARY_VERSION=$(echo $SCALA_VERSION | cut -f 1-2 -d '.'); \
  mkdir -p /opt/kafka; \
  curl -s   -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc https://www.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc; \
  curl -SLs -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz"; \
  gpg --verify kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  tar xzf kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz --strip-components=1 -C /opt/kafka; \
  rm kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  \
  rm -rf /opt/kafka/site-docs; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
