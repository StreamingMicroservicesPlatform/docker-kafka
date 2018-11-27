FROM debian:9.6-slim@sha256:f05c05a218b7a4a5fe979045b1c8e2a9ec3524e5611ebfdd0ef5b8040f9008fa

# See https://jdk.java.net/11/

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  cd /usr/lib; \
  mkdir jvm; \
  cd jvm; \
  curl -SLs -o jdk.tar.gz https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz; \
  echo "7a6bb980b9c91c478421f865087ad2d69086a0583aeeb9e69204785e8e97dcfd jdk.tar.gz" | sha256sum -c -; \
  tar xvzf jdk.tar.gz; \
  rm jdk.tar.gz; \
  mv jdk-11.0.1 jdk-11; \
  \
  rm -v jdk-11/lib/src.zip; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

# Instead of: find /usr/lib/jvm/jdk-11/bin/ -executable -exec ln -s '{}' /usr/local/bin/
ENV PATH="$PATH:/usr/lib/jvm/jdk-11/bin"
