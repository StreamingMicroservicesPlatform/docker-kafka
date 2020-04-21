FROM adoptopenjdk:11.0.7_10-jre-hotspot-bionic@sha256:a119e89693cfca250cecc3756c5efb5fdf523d93d813003b3c2a1d29d8884211

ENV EXPORTER_VERSION=76cf1bf03c4cd4a050eb089f37af6a8af15abf0a
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
