FROM solsson/kafka-jre:8@sha256:1ebc3c27c30f5925d240aaa0858e111c2fa6d358048b0f488860ea9cd9c84822

ENV KAFKA_MONITOR_REPO=https://github.com/linkedin/kafka-monitor \
    KAFKA_MONITOR_VERSION=2.0.0 \
    KAFKA_MONITOR_SHA256=3713a76a970bd99e72fe8ce1c8be77d4b036057367352265a70ad23b55acef35

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates unzip'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  cd /opt; \
  GRADLE_VERSION=4.3.1 PATH=$PATH:$(pwd)/gradle-$GRADLE_VERSION/bin; \
  curl -SLs -o gradle-$GRADLE_VERSION-bin.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip; \
  echo "15ebe098ce0392a2d06d252bff24143cc88c4e963346582c8d88814758d93ac7  gradle-$GRADLE_VERSION-bin.zip" | sha256sum -c -; \
  unzip gradle-$GRADLE_VERSION-bin.zip; \
  rm gradle-$GRADLE_VERSION-bin.zip; \
  gradle -v; \
  \
  mkdir -p /opt/kafka-monitor; \
  curl -o monitor.tar.gz -SLs "$KAFKA_MONITOR_REPO/archive/$KAFKA_MONITOR_VERSION.tar.gz"; \
  echo "$KAFKA_MONITOR_SHA256  monitor.tar.gz" | sha256sum -c; \
  tar -xzf monitor.tar.gz --strip-components=1 -C /opt/kafka-monitor; \
  rm monitor.tar.gz; \
  \
  cd /opt/kafka-monitor; \
  ./gradlew jar; \
  \
  sed -i 's/localhost:2181/zookeeper:2181/' config/kafka-monitor.properties; \
  sed -i 's/localhost:9092/bootstrap:9092/' config/kafka-monitor.properties; \
  \
  cat config/kafka-monitor.properties; \
  cat config/log4j.properties; \
  \
  rm -rf /opt/gradle* /root/.gradle; \
  \
  apt-get purge -y --auto-remove $buildDeps nodejs; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

WORKDIR /opt/kafka-monitor

ENTRYPOINT ["./bin/kafka-monitor-start.sh"]
CMD ["/opt/kafka-monitor/config/kafka-monitor.properties"]
