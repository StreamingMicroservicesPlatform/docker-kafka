FROM solsson/kafka-jre

ENV KAFKA_VERSION=0.11.0.0 KAFKA_BIN_SCALA_VERSION=2.11

RUN set -ex; \
  runDeps='netcat-openbsd'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  mkdir -p /opt/kafka; \
  curl -SLs "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$KAFKA_BIN_SCALA_VERSION-$KAFKA_VERSION.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
