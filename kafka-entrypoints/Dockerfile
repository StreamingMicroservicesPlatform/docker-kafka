FROM solsson/kafka:nonroot

USER root

RUN sed -i 's|  exec |  echo -n |' ./bin/kafka-run-class.sh

USER nonroot:nogroup
