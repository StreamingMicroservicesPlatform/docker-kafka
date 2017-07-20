FROM solsson/kafka

RUN apt-get update && apt-get install -y maven --no-install-recommends

# TODO sort out where Zulu is, and/or tools.jar
RUN apt-get update && apt-get install -y openjdk-8-jdk-headless --no-install-recommends

RUN set -ex; \
  mkdir /usr/src/kafka-connect; \
  cd /usr/src/kafka-connect; \
  curl -SLs https://github.com/srijiths/kafka-connectors/archive/dc0a7122650e697d3ae97c970a4785bbed949479.tar.gz \
    | tar -xzf - --strip-components=1 -C ./; \
  mvn clean install;

# /usr/share/java is the recommendation from http://docs.confluent.io/current/cp-docker-images/docs/intro.html#important-notes-caveats
RUN mv ~/.m2/repository/com/sree/kafka/kafka-connect-jmx/0.0.1/kafka-connect-jmx-0.0.1-jar-with-dependencies.jar /usr/share/java/

ENTRYPOINT ["./bin/connect-standalone.sh"]
CMD ["./config/connect-standalone.properties", "/usr/src/kafka-connect/kafka-connect-jmx/config/sample-jmx-configuration.properties"]
