FROM solsson/kafka

RUN groupadd -g 65532 nonroot && \
  useradd --create-home --home-dir /home/nonroot --uid 65532 --gid 65532 -c nonroot -s /usr/sbin/nologin nonroot
USER nonroot:nonroot
