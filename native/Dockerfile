FROM solsson/kafka:graalvm

# Should be identical to kafka-nonroot's user
RUN echo 'nonroot:x:65532:65534:nonroot:/home/nonroot:/usr/sbin/nologin' >> /etc/passwd && \
  mkdir -p /home/nonroot && touch /home/nonroot/.bash_history && chown -R 65532:65534 /home/nonroot
USER nonroot:nogroup

COPY --from=solsson/kafka:nonroot /opt/kafka /opt/kafka
COPY --from=solsson/kafka:nonroot /etc/kafka /etc/kafka
