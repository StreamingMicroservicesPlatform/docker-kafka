# Select digest to have the same FROM as kafka-jre
FROM solsson/kafkacat@sha256:ebebf47061300b14a4b4c2e1e4303ab29f65e4b95d34af1b14bb8f7ec6da7cef

ENV KUBERNETES_VERSION=1.8.2 KUBERNETES_CLIENTS_SHA256=7c20d4a3859c07aadf9a1676876bafdf56187478a69d3bfca5277fb275febb96

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
