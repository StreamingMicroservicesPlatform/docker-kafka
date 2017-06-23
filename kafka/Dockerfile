FROM openjdk:8u131-jre-alpine

ENV KAFKA_VERSION=0.11.0.0-rc2 SCALA_VERSION=2.12.2

RUN set -e; cd /usr/local; \
  GRADLE_VERSION=4.0 PATH=$PATH:$(pwd)/gradle-$GRADLE_VERSION/bin; \
  apk add --no-cache curl openjdk8="$JAVA_ALPINE_VERSION"; \
  curl -SLs -o gradle-$GRADLE_VERSION-bin.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip; \
  unzip gradle-$GRADLE_VERSION-bin.zip; \
  rm gradle-$GRADLE_VERSION-bin.zip; \
  gradle -v;

RUN set -e; cd /usr/local; \
  export PATH=$PATH:/usr/local/gradle-4.0/bin; \
  mkdir build-kafka; \
  curl -SLs "https://github.com/apache/kafka/archive/$KAFKA_VERSION.tar.gz" | tar -xzf - --strip-components=1 -C ./build-kafka; \
  cd build-kafka; \
  sed -i "s/scalaVersion=.*/scalaVersion=$SCALA_VERSION/" gradle.properties; \
  gradle; \
  #./gradlew test; \
  ./gradlew jar

RUN mkdir -p /usr/local/kafka/config && touch /usr/local/kafka/config/server.properties

WORKDIR /usr/local/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]
