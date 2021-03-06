FROM ubuntu:20.04@sha256:c844b5fee673cd976732dda6860e09b8f2ae5b324777b6f9d25fd70a0904c2e0

WORKDIR /usr/local
COPY --from=solsson/kafka:native-kafka-topics /usr/local/bin/* /usr/local/bin/
COPY --from=solsson/kafka:native-kafka-configs /usr/local/bin/* /usr/local/bin/
COPY --from=solsson/kafka:native-kafka-consumer-groups /usr/local/bin/* /usr/local/bin/

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='ca-certificates netcat-openbsd libsnappy1v5 liblz4-1 libzstd1 kafkacat jq'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  rm -rf /var/lib/apt/lists; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /root/.gnupg

COPY cli-scripts/* /usr/local/bin/

RUN for sh in $(find /usr/local/bin/ -name *.sh); do \
  ln -s $sh $(echo -n $sh | sed 's/\.sh$//'); \
  done

# Should be identical to kafka-nonroot's user
RUN echo 'nonroot:x:65532:65534:nonroot:/home/nonroot:/usr/sbin/nologin' >> /etc/passwd && \
  mkdir -p /home/nonroot && touch /home/nonroot/.bash_history && chown -R 65532:65534 /home/nonroot
USER nonroot:nogroup

ENTRYPOINT [ "cli-list" ]
