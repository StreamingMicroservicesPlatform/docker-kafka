# same FROM as kafka-jre, to keep pull times down and to provide the same shell distro+version
FROM debian:stable-20170620

ENV KUBERNETES_VERSION=1.7.2 KUBERNETES_CLIENTS_SHA256=9c2363710d61a12a28df2d8a4688543b785156369973d33144ab1f2c1d5c7b53

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='curl ca-certificates'; \
  buildDeps=''; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v1.7.2/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENTS_SHA256  k.tar.gz" | sha256sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log
