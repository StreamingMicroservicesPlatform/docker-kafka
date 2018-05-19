# The only assumption we make about this FROM is that it has a JRE in path
FROM solsson/kafka-jre@sha256:06dabfc8cacd0687c8f52c52afd650444fb6d4a8e0b85f68557e6e7a5c71667c

ENV KSQL_VERSION=5.0.0~beta1-1

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates gnupg2 apt-transport-https'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -SLs https://packages.confluent.io/deb/5.0/archive.key | apt-key add -; \
  echo "deb [arch=amd64] https://packages.confluent.io/deb/5.0 stable main" > /etc/apt/sources.list.d/confluent.list; \
  \
  apt-get update; \
  apt-get -s install confluent-ksql | grep confluent; \
  \
  apt-get install -y \
    confluent-ksql=$KSQL_VERSION \
    --no-install-recommends; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt
