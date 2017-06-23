FROM openjdk:8u131-jre-alpine

ENV KAFKA_VERSION=0.11.0.0-rc2

RUN set -e; cd /usr/local; \
  GRADLE_VERSION=4.0 PATH=$PATH:$(pwd)/gradle-$GRADLE_VERSION/bin; \
  apk add --no-cache curl; \
  curl -SLs -o gradle-$GRADLE_VERSION-bin.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip; \
  unzip gradle-$GRADLE_VERSION-bin.zip; \
  rm gradle-$GRADLE_VERSION-bin.zip; \
  gradle -v; \
  \
  gradle

RUN set -e; cd /usr/local; \
  export PATH=$PATH:/usr/local/gradle-4.0/bin; \
  mkdir kafka-build; \
  curl -SLs "https://github.com/apache/kafka/archive/$KAFKA_VERSION.tar.gz" | tar -xzf - --strip-components=1 -C ./kafka-build; \
  cd kafka-build; \
  ls -la

RUN mkdir -p /usr/local/kafka/config && touch /usr/local/kafka/config/server.properties

WORKDIR /usr/local/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
