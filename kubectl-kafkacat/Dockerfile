# Select digest to have the same FROM as kafka-jre
FROM solsson/kafkacat@sha256:be85344e8932d5dd4492fb37122be0bb9e65e560fe960058e0460ec13eea6547

ENV KUBERNETES_VERSION=1.8.5 KUBERNETES_CLIENTS_SHA256=c32b6f90f1e8a15451f0d412d6d1f3db28948d2f7d76d4e28d83c11e1eb25f20

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='procps'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENTS_SHA256  k.tar.gz" | sha256sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log

ENTRYPOINT ["kubectl"]
