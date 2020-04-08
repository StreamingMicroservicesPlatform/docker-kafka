FROM solsson/kafka:nativeagent-graalvm

# Should be identical to kafka-nonroot's user
RUN useradd --create-home --home-dir /home/nonroot --uid 65532 --gid 65534 -c nonroot -s /usr/sbin/nologin nonroot
USER nonroot:nogroup

COPY --from=solsson/kafka:nonroot /opt/kafka /opt/kafka
COPY --from=solsson/kafka:nonroot /etc/kafka /etc/kafka
