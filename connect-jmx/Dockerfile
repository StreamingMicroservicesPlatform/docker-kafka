FROM solsson/kafka:0.11.0.0

# Note: this is an experimental build that isn't at all optimized to reduce size

RUN apt-get update && apt-get install -y maven curl ca-certificates --no-install-recommends

# TODO sort out where Zulu is, and/or tools.jar
RUN apt-get update && apt-get install -y openjdk-8-jdk-headless --no-install-recommends

RUN set -ex; \
  mkdir /usr/src/kafka-connect; \
  cd /usr/src/kafka-connect; \
  curl -SLs https://github.com/srijiths/kafka-connectors/archive/dc0a7122650e697d3ae97c970a4785bbed949479.tar.gz \
    | tar -xzf - --strip-components=1 -C ./; \
  mvn clean install;

RUN mv ~/.m2/repository/com/sree/kafka/kafka-connect-jmx/0.0.1/kafka-connect-jmx-0.0.1-jar-with-dependencies.jar ./libs/

COPY *.properties ./config/

ENTRYPOINT ["./bin/connect-standalone.sh"]
CMD ["./config/worker.properties", "./config/connect-jmx.properties"]
