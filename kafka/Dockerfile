FROM openjdk:8u131-jre-alpine

ENV KAFKA_VERSION=0.11.0.0 SCALA_VERSION=2.12.2

RUN set -e; cd /usr/local; \
  GRADLE_VERSION=4.0 PATH=$PATH:$(pwd)/gradle-$GRADLE_VERSION/bin; \
  apk add  --no-cache --virtual .build-deps \
    curl \
    openjdk8="$JAVA_ALPINE_VERSION"; \
  curl -SLs -o gradle-$GRADLE_VERSION-bin.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip; \
  unzip gradle-$GRADLE_VERSION-bin.zip; \
  rm gradle-$GRADLE_VERSION-bin.zip; \
  gradle -v; \
  \
  mkdir build; \
  curl -SLs "https://github.com/apache/kafka/archive/$KAFKA_VERSION.tar.gz" | tar -xzf - --strip-components=1 -C ./build; \
  cd build; \
  sed -i "s/scalaVersion=.*/scalaVersion=$SCALA_VERSION/" gradle.properties; \
  gradle; \
  ./gradlew unitTest; \
  ./gradlew integrationTest; \
  ./gradlew jar; \
  gradle --stop; \
  cd ..; \
  \
  rm gradle-$GRADLE_VERSION -Rf; \
  rm ~/.gradle -Rf; \
  apk del .build-deps; \
  \
  mkdir -p kafka/core/build kafka/clients/build; \
  mv build/core/build/libs             kafka/core/build/; \
  mv build/core/build/dependant-libs-* kafka/core/build/; \
  mv build/clients/build/libs          kafka/clients/build/; \
  mv build/config kafka/; \
  mv build/bin    kafka/; \
  rm kafka/bin/windows -Rf; \
  rm build -Rf

RUN apk add --no-cache bash

WORKDIR /usr/local/kafka
ENTRYPOINT ["bin/kafka-server-start.sh"]

RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/' config/server.properties
CMD ["config/server.properties"]

RUN set -e; \
  sed -i 's/^\(.*\)\.DatePattern=/#\1.DatePattern=/' config/log4j.properties; \
  sed -i 's/^\(.*\)\.File=/#\1.File=/' config/log4j.properties; \
  \
  sed -i 's/^\(.*\)=org.apache.log4j.DailyRollingFileAppender/\1=org.apache.log4j.ConsoleAppender\n#\1=org.apache.log4j.DailyRollingFileAppender/' config/log4j.properties
