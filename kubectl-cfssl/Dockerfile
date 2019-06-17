FROM cfssl/cfssl@sha256:525005bc4e39d61a2302490329e414eab13ee7ec3edf261df5da68ff65cb506b \
  as cfssl

RUN whereis cfssl
RUN whereis cfssljson

FROM debian:stretch-slim@sha256:9490c476443a3869e39c2897fa66c91daf5dcbbfca53c976dac7bbdc45775b28

ENV KUBERNETES_VERSION=1.14.3 KUBERNETES_CLIENTS_SHA256=47ada9a1743d3f45c2443a6bf37a5f8c16a77601c91e3d27e83f7c9c5cca0737

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

RUN kubectl version --client

COPY --from=cfssl /go/bin/cfssl* /usr/local/bin/
RUN cfssl version
