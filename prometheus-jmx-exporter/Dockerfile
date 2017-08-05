FROM solsson/kafka-jre@sha256:7765513cf5fa455a672a06f584058c1c81cc0b3b56cc56b0cfdf1a917a183f26

ENV EXPORTER_VERSION=parent-0.10
ENV EXPORTER_REPO=github.com/prometheus/jmx_exporter

WORKDIR /usr/local/

RUN set -ex; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  MAVEN_VERSION=3.5.0 PATH=$PATH:$(pwd)/maven/bin; \
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
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

# Use a sample config that also has a Grafana dashboard https://blog.rntech.co.uk/2016/10/20/monitoring-apache-kafka-with-prometheus/
# Mount your own yml, for example using ConfigMap, or set Kafka JMX_PORT=5555
RUN set -ex; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $buildDeps --no-install-recommends; \
  curl -SLs -o example_configs/kafka-prometheus-monitoring.yml \
    https://raw.githubusercontent.com/rama-nallamilli/kafka-prometheus-monitoring/c4ee0e6b03386375b9b9e66b3fcbf4a704bec8f5/prometheus-jmx-exporter/confd/templates/kafka.yml.tmpl; \
  sed -i 's|{{ getv "/jmx/host" }}|127.0.0.1|' example_configs/kafka-prometheus-monitoring.yml; \
  sed -i 's|{{ getv "/jmx/port" }}|5555|'      example_configs/kafka-prometheus-monitoring.yml; \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/apt

ENTRYPOINT ["java", "-jar", "jmx_prometheus_httpserver.jar"]
CMD ["5556", "example_configs/kafka-prometheus-monitoring.yml"]
