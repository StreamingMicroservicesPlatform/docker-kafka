FROM gcr.io/distroless/base-debian10:debug-nonroot@sha256:ad9cb88a4d4e6969b44137de488c2a21e0e53d32a7eed601b39bf760bfdf14d0

COPY --from=solsson/kafka:native-kafka-topics \
  /lib/x86_64-linux-gnu/libz.so.* \
  /lib/x86_64-linux-gnu/

COPY --from=solsson/kafka:native-kafka-topics \
  /usr/lib/x86_64-linux-gnu/libzstd.so.* \
  /usr/lib/x86_64-linux-gnu/libsnappy.so.* \
  /usr/lib/x86_64-linux-gnu/liblz4.so.* \
  /usr/lib/x86_64-linux-gnu/

WORKDIR /usr/local
COPY --from=solsson/kafka:native-kafka-topics /usr/local/bin/* /usr/local/bin/

# RUN ln -s ./bin/kafka-topics.sh ./bin/kafka-topics
# ENTRYPOINT [ "ls", "-l", "/usr/local/bin/*" ]
