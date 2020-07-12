# same FROM as kafka-jre, to keep pull times down and to provide the same shell distro+version
FROM ubuntu:bionic@sha256:bec5a2727be7fff3d308193cfde3491f8fba1a2ba392b7546b43a051853a341d

ENV KUBERNETES_VERSION=1.17.5 KUBERNETES_CLIENT_SHA512=4cf67f972aad3425bccc48af83f8cb59ddcc96de49d3bb21cdbbcbbeee31718ef681e551d13343538a6e70c2a4ea0435e4540bc1f8cf1a91a2f73265f52b9429

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='curl ca-certificates procps netcat'; \
  buildDeps=''; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  rm -rf /var/lib/apt/lists/*; \
  \
  curl -sLS -o k.tar.gz -k https://dl.k8s.io/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz; \
  echo "$KUBERNETES_CLIENT_SHA512  k.tar.gz" | sha512sum -c; \
  tar -xvzf k.tar.gz -C /usr/local/bin/ --strip-components=3 kubernetes/client/bin/kubectl; \
  rm k.tar.gz; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm /var/log/dpkg.log /var/log/apt/*.log
