FROM adoptopenjdk:11.0.6_10-jdk-hotspot@sha256:4be6d6e43ffb3ebac9ef4f4c2ea61e374690dd8ac39014bc7ca84c3ae2f26b6e

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='ca-certificates netcat-openbsd libsnappy1v5 liblz4-1 libzstd1'; \
  buildDeps='curl gnupg dirmngr libsnappy-dev liblz4-dev libzstd1-dev'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  # Keeping build deps for native compile
  #apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /root/.gnupg

ENV GRAALVM_VERSION=20.0.0

RUN set -ex; \
  cd /opt; \
  curl -sLS -o graalvm.tar.gz https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz; \
  tar xvzf graalvm.tar.gz; \
  mv graalvm-ce-java11-${GRAALVM_VERSION} graalvm; \
  rm graalvm.tar.gz

ENV PATH=/opt/java/openjdk/bin:/opt/graalvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN gu install native-image
