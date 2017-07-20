FROM debian:stable-20170620

ENV KAFKA_VERSION=0.11.0.0
ENV kafka_bin_version=2.11-$KAFKA_VERSION

RUN set -ex; \
  runDeps='default-jre'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  mkdir -p /opt/kafka; \
  curl -SLs "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$kafka_bin_version.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log

WORKDIR /opt/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
