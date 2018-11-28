FROM solsson/jdk-opensource:11.0.1@sha256:740feb6c1ecbdf2beac1dc41405c3215511b90d83a7211f805e88f92946dd2a9

ENV EXPORTER_VERSION=parent-0.3.1
ENV EXPORTER_REPO=github.com/prometheus/jmx_exporter

WORKDIR /usr/local/

RUN set -ex; \
  DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  MAVEN_VERSION=3.5.2 PATH=$PATH:$(pwd)/maven/bin; \
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

COPY collect-all-slow.yml example_configs/

ENTRYPOINT ["java", "-jar", "jmx_prometheus_httpserver.jar"]
CMD ["5556", "example_configs/collect-all-slow.yml"]
