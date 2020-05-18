FROM solsson/kafka:initutils

# Note that there's also a nouser 65534 user which has no writable home
RUN echo 'nonroot:x:65532:65534:nonroot:/home/nonroot:/usr/sbin/nologin' >> /etc/passwd && \
  mkdir -p /home/nonroot && touch /home/nonroot/.bash_history && chown -R 65532:65534 /home/nonroot
USER nonroot:nogroup

WORKDIR /home/nonroot
