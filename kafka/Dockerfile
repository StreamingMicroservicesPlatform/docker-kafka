# The only assumption we make about this FROM is that it has a JRE in path
FROM solsson/kafka-jre@sha256:6ceb312a233f7903f554cf0d9391e9b5a927ebe9d807480506aee4d16d96bb71

ENV KAFKA_VERSION=1.0.2 SCALA_VERSION=2.11

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='netcat-openbsd'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  SCALA_BINARY_VERSION=$(echo $SCALA_VERSION | cut -f 1-2 -d '.'); \
  mkdir -p /opt/kafka; \
  curl -SLs "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka; \
  \
  rm -rf /opt/kafka/site-docs; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
