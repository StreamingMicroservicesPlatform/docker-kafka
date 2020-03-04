FROM solsson/kafka

RUN mkdir logs && chgrp nogroup logs && chmod g+w logs
RUN ln -s $(pwd)/config /etc/kafka

# These envs affect the generating of entrypoints in ../kafka-entrypoinst
# Values are based on Yolean/kubernetes-kafka
ENV CLASSPATH="/opt/kafka/libs/extensions/*"
ENV KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/etc/kafka/log4j.properties"

# Note that there's also a nouser 65534 user which has no writable home
RUN useradd --create-home --home-dir /home/nonroot --uid 65532 --gid 65534 -c nonroot -s /usr/sbin/nologin nonroot
USER nonroot:nogroup
