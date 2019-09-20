FROM ubuntu:18.04@sha256:b88f8848e9a1a4e4558ba7cfc4acc5879e1d0e7ac06401409062ad2627e6fb58 \
  as install

RUN set -e; \
  export DEBIAN_FRONTEND=noninteractive; \
  apt-get update; \
  apt-get install -y --no-install-recommends ca-certificates

FROM ubuntu:18.04@sha256:b88f8848e9a1a4e4558ba7cfc4acc5879e1d0e7ac06401409062ad2627e6fb58

COPY --from=install /usr/sbin/update-ca-certificates /usr/sbin/update-ca-certificates
