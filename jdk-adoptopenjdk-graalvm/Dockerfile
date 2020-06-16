FROM adoptopenjdk:11.0.7_10-jdk-hotspot-bionic@sha256:c2ce12d7530d957f2d44dd33339eeeafa3b889c27af0824b186c4afef1f843ef

COPY --from=maven:3.6.3-jdk-11-slim@sha256:18f059e73cffdf1688093e2e82f1001a7cd2baa9de92e7b8d05bf34a8318ee92 \
  /usr/share/maven /usr/share/maven
RUN ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_CONFIG=/root/.m2

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='ca-certificates netcat-openbsd libsnappy1v5 liblz4-1 libzstd1'; \
  buildDeps='curl gnupg dirmngr gcc libc6-dev zlib1g-dev libsnappy-dev liblz4-dev libzstd1-dev'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  # Keeping build deps for native compile
  #apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /root/.gnupg

ARG graalvm_version=20.1.0
ARG graalvm_variant=java11
ARG graalvm_releases=graalvm/graalvm-ce-builds
ARG graalvm_build=

RUN set -ex; \
  cd /opt; \
  curl -sLS -o graalvm.tar.gz https://github.com/${graalvm_releases}/releases/download/vm-${graalvm_version}${graalvm_build}/graalvm-ce-${graalvm_variant}-linux-amd64-${graalvm_version}.tar.gz; \
  tar xvzf graalvm.tar.gz; \
  mv graalvm-ce-${graalvm_variant}-${graalvm_version} graalvm; \
  rm graalvm.tar.gz

ENV PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/graalvm/bin

RUN gu install native-image
