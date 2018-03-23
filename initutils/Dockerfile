# same FROM as kafka-jre, to keep pull times down and to provide the same shell distro+version
FROM debian:stretch-slim@sha256:ea42520331a55094b90f6f6663211d4f5a62c5781673935fe17a4dfced777029

ENV KUBERNETES_VERSION=1.9.6 KUBERNETES_CLIENT_SHA256=2b1ab65171bcd43a099d4f7d05d7804c737272270e83f633e1c14ceed9a99133

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='curl ca-certificates procps netcat'; \
  buildDeps=''; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENT_SHA256  k.tar.gz" | sha256sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log
