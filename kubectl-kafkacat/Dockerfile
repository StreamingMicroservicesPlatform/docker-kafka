# Select digest to have the same FROM as kafka-jre
FROM solsson/kafkacat@sha256:1266d140c52cb39bf314b6f22b6d7a01c4c9084781bc779fdfade51214a713a8

ENV KUBERNETES_VERSION=1.7.2

RUN set -ex; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  mkdir /usr/local/kubernetes; \
  curl -SLs "https://dl.k8s.io/v$KUBERNETES_VERSION/kubernetes-client-linux-amd64.tar.gz" | tar -xvzf - --strip-components=1 -C /usr/local/kubernetes; \
  \
  mv /usr/local/kubernetes/client/bin/kubectl /usr/local/bin/; \
  rm -rf /usr/local/kubernetes; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log

ENTRYPOINT ["kubectl"]
