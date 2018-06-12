FROM solsson/kafka-jre@sha256:06dabfc8cacd0687c8f52c52afd650444fb6d4a8e0b85f68557e6e7a5c71667c

ENV KAFKA_MANAGER_VERSION=1.3.3.17

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates unzip apt-transport-https gnupg2 lsb-release'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -; \
  echo "deb https://deb.nodesource.com/node_8.x stretch main" > /etc/apt/sources.list.d/nodesource.list; \
  apt-get update && apt install -y --no-install-recommends nodejs; \
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
  apt-get purge -y --auto-remove $buildDeps nodejs; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka-manager

ENTRYPOINT ["./bin/kafka-manager"]
