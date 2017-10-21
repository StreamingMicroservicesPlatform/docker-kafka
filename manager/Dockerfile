FROM solsson/kafka-jre@sha256:06dabfc8cacd0687c8f52c52afd650444fb6d4a8e0b85f68557e6e7a5c71667c

ENV KAFKA_MANAGER_VERSION=1.3.3.14

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates unzip'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  mkdir -p /opt/kafka-manager-src; \
  curl -SLs "https://github.com/yahoo/kafka-manager/archive/$KAFKA_MANAGER_VERSION.tar.gz" | tar -xzf - --strip-components=1 -C /opt/kafka-manager-src; \
  \
  cd /opt/kafka-manager-src; \
  ./sbt clean dist; \
  \
  cd /opt; \
  unzip kafka-manager-src/target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.zip; \
  mv kafka-manager-$KAFKA_MANAGER_VERSION kafka-manager; \
  \
  rm -rf /root/.sbt /root/.ivy2 /opt/kafka-manager-src; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka-manager

ENTRYPOINT ["./bin/kafka-manager"]
