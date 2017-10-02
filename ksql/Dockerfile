FROM solsson/kafka:0.11.0.1

ENV ksql_repo=https://github.com/confluentinc/ksql ksql_version=dc1ad22e95793252c47f2a66656417e64e0fec21

RUN set -ex; \
  buildDeps='curl ca-certificates'; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update && apt-get install -y $buildDeps --no-install-recommends; \
  \
  MAVEN_VERSION=3.5.0 PATH=$PATH:$(pwd)/maven/bin; \
  mkdir ./maven; \
  curl -SLs https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - --strip-components=1 -C ./maven; \
  mvn --version; \
  \
  mkdir ./ksql; \
  cd ./ksql; \
  curl -SLs ${ksql_repo}/archive/${ksql_version}.tar.gz \
    | tar -xzf - --strip-components=1 -C ./; \
  mvn package install; \
echo "temp layer";
RUN echo "temp layer"; \
  cd ..; \
  mv ~/.m2/repository/com/sree/kafka/kafka-connect-jmx/0.0.1/kafka-connect-jmx-0.0.1-jar-with-dependencies.jar ./libs/; \
  rm -rf ./ksql; \
  rm -rf ./maven ~/.m2; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm /var/log/dpkg.log /var/log/apt/*.log

COPY *.properties ./config/

ENTRYPOINT ["./bin/connect-standalone.sh"]
CMD ["./config/worker.properties", "./config/connect-jmx.properties"]
