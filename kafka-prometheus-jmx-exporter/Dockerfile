FROM openjdk:8u131-jre-alpine

ENV EXPORTER_VERSION=8ded2c5e112f8c458e60398c528799ca763c78ac
ENV EXPORTER_REPO=github.com/prometheus/jmx_exporter

WORKDIR /usr/local/

RUN set -e; \
  MAVEN_VERSION=3.5.0 PATH=$PATH:$(pwd)/maven/bin; \
  apk add  --no-cache --virtual .build-deps \
    curl \
    openjdk8="$JAVA_ALPINE_VERSION"; \
  mkdir ./maven; \
  curl -SLs https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - --strip-components=1 -C ./maven; \
  mvn --version; \
  \
  mkdir ./jmx_exporter; \
  curl -SLs https://$EXPORTER_REPO/archive/$EXPORTER_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./jmx_exporter; \
  cd ./jmx_exporter; \
  mvn package; \
  find jmx_prometheus_httpserver/ -name *-jar-with-dependencies.jar -exec mv -v '{}' ../jmx_prometheus_httpserver.jar \;; \
  mv example_configs ../; \
  cd ..; \
  \
  rm -Rf ./jmx_exporter ./maven /root/.m2; \
  apk del .build-deps;

RUN apk add --no-cache bash

# Use a sample config that also has a Grafana dashboard https://blog.rntech.co.uk/2016/10/20/monitoring-apache-kafka-with-prometheus/
# Mount your own yml, for example using ConfigMap, or set Kafka JMX_PORT=5555
RUN apk add  --no-cache --virtual .build-deps curl; \
  curl -SLs -o example_configs/kafka-prometheus-monitoring.yml \
    https://raw.githubusercontent.com/rama-nallamilli/kafka-prometheus-monitoring/c4ee0e6b03386375b9b9e66b3fcbf4a704bec8f5/prometheus-jmx-exporter/confd/templates/kafka.yml.tmpl; \
  sed -i 's|{{ getv "/jmx/host" }}|127.0.0.1|' example_configs/kafka-prometheus-monitoring.yml; \
  sed -i 's|{{ getv "/jmx/port" }}|5555|'      example_configs/kafka-prometheus-monitoring.yml; \
  apk del .build-deps;

ENTRYPOINT ["java", "-jar", "jmx_prometheus_httpserver.jar"]
CMD ["5556", "example_configs/kafka-prometheus-monitoring.yml"]
