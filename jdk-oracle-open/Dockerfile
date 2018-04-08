FROM debian:stretch-slim@sha256:613efd414e9818dcef858201484a94603a548a0e04fd4356e77eb758aeb16124

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  cd /usr/lib; \
  mkdir jvm; \
  cd jvm; \
  curl -SLs -o jdk.tar.gz https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz; \
  echo "c851df838a51af52517b74e3a4b251d90c54cf478a4ebed99e7285ef134c3435 jdk.tar.gz" | sha256sum -c -; \
  tar xvzf jdk.tar.gz; \
  rm jdk.tar.gz; \
  \
  rm -v jdk-10/lib/src.zip; \
  rm -r jdk-10/man/; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

# Instead of: find /usr/lib/jvm/jdk-10/bin/ -executable -exec ln -s '{}' /usr/local/bin/
ENV PATH="$PATH:/usr/lib/jvm/jdk-10/bin"
