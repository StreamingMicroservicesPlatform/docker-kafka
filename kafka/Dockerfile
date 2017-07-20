FROM debian:stable-20170620

ENV KAFKA_VERSION=0.11.0.0 ZULU_OPENJDK_VERSION="8=8.21.0.1"
ENV kafka_bin_version=2.11-$KAFKA_VERSION

RUN set -ex; \
  runDeps=''; \
  buildDeps='curl ca-certificates gnupg dirmngr'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9; \
  echo 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list; \
  apt-get update && apt-get install -y zulu-${ZULU_OPENJDK_VERSION} --no-install-recommends; \
  \
  mkdir -p /opt/kafka; \
  curl -SLs "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$kafka_bin_version.tgz" | tar -xzf - --strip-components=1 -C /opt/kafka; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm /var/log/dpkg.log /var/log/apt/*.log

WORKDIR /opt/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
