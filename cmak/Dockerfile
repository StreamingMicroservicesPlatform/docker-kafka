FROM adoptopenjdk:11.0.7_10-jdk-hotspot-bionic@sha256:05df284aea654234eb1de8d8346a0079c33ab03adda1262f92971c39388e99e8 \
  as build

ENV CMAK_VERSION=3.0.0.5
ENV CMAK_ARCHIVE=https://github.com/yahoo/CMAK/archive/${CMAK_VERSION}.tar.gz

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates unzip apt-transport-https gnupg2 lsb-release'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -; \
  echo "deb https://deb.nodesource.com/node_8.x stretch main" > /etc/apt/sources.list.d/nodesource.list; \
   apt-get update && apt install -y --no-install-recommends nodejs; \
  \ 
  mkdir -p /opt/cmak-src; \
  curl -SLs "${CMAK_ARCHIVE}" | tar -xzf - --strip-components=1 -C /opt/cmak-src; \
  \
  cd /opt/cmak-src; \
  ./sbt clean dist; \
  \
  cd /opt; \
  unzip cmak-src/target/universal/cmak-$CMAK_VERSION.zip; \
  mv cmak-$CMAK_VERSION cmak; \
  \
  rm -rf /root/.sbt /root/.ivy2 /opt/cmak-src; \
  \
  apt-get purge -y --auto-remove $buildDeps nodejs; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

FROM adoptopenjdk:11.0.7_10-jre-hotspot-bionic@sha256:a119e89693cfca250cecc3756c5efb5fdf523d93d813003b3c2a1d29d8884211

COPY --from=build /opt/cmak /opt/cmak

WORKDIR /opt/cmak

ENTRYPOINT ["./bin/cmak"]

# Should be identical to kafka-nonroot's user
RUN echo 'nonroot:x:65532:65534:nonroot:/home/nonroot:/usr/sbin/nologin' >> /etc/passwd && \
  mkdir -p /home/nonroot && touch /home/nonroot/.bash_history && chown -R 65532:65534 /home/nonroot
RUN chmod g+w /opt/cmak && chgrp nogroup /opt/cmak
USER nonroot:nogroup
