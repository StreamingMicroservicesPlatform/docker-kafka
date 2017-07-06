FROM solsson/kafkacat@sha256:36d1f191cc33a8365074280279205e6b4f52cd8cc8fb1b896bb4c943c9dee8f8

ENV KUBERNETES_VERSION=1.7.0

RUN buildDeps='curl ca-certificates'; \
  set -ex; \
  apt-get update && apt-get install -y $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  mkdir /usr/local/kubernetes; \
  curl -SLs "https://dl.k8s.io/v$KUBERNETES_VERSION/kubernetes-client-linux-amd64.tar.gz" | tar -xvzf - --strip-components=1 -C /usr/local/kubernetes; \
  \
  mv /usr/local/kubernetes/client/bin/kubectl /usr/local/bin/; \
  rm -rf /usr/local/kubernetes; \
  \
  apt-get purge -y --auto-remove $buildDeps
