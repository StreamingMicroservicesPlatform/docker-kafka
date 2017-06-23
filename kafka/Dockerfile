FROM gradle:3.5-jdk8-alpine

ARG kafka_version=0.11.0.0-rc1

RUN mkdir -p /opt/kafka \
  && curl -SLs "https://github.com/apache/kafka/archive/0.11.0.0-rc1.tar.gz" | tar -xzf - --strip-components=1 -C /src/kafka \
  && cd /src/kafka \
  && gradle \
  && gradlew jar \
  && ls -la

WORKDIR /opt/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
