# The only assumption we make about this FROM is that it has a JRE in path
FROM solsson/kafka-jre@sha256:7765513cf5fa455a672a06f584058c1c81cc0b3b56cc56b0cfdf1a917a183f26

ENV KAFKA_MANAGER_VERSION=1.3.3.8

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  mkdir -p /opt/kafka-manager; \
  curl -SLs "https://github.com/yahoo/kafka-manager/archive/$KAFKA_MANAGER_VERSION.tar.gz" | tar -xzf - --strip-components=1 -C /opt/kafka-manager; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka-manager

ENTRYPOINT ["./bin/kafka-manager"]
