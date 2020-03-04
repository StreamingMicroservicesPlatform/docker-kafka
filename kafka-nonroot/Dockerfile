FROM solsson/kafka

RUN mkdir logs && chgrp nogroup logs && chmod g+w logs

# Note that there's also a nouser 65534 user which has no writable home
RUN useradd --create-home --home-dir /home/nonroot --uid 65532 --gid 65534 -c nonroot -s /usr/sbin/nologin nonroot
USER nonroot:nogroup
