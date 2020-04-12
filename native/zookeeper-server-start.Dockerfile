FROM solsson/kafka:nativebase

#RUN curl -L -o /home/nonroot/slf4j-simple-1.7.28.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/1.7.28/slf4j-simple-1.7.28.jar

# TODO extract from entrypoint
ARG classpath=/opt/kafka/bin/../libs/log4j-1.2.17.jar:/opt/kafka/bin/../libs/slf4j-api-1.7.28.jar:/opt/kafka/bin/../libs/slf4j-log4j12-1.7.28.jar:/opt/kafka/bin/../libs/zookeeper-3.5.7.jar:/opt/kafka/bin/../libs/zookeeper-jute-3.5.7.jar

COPY configs/zookeeper-server-start /home/nonroot/native-config

RUN native-image \
  --no-server \
  -H:+ReportExceptionStackTraces \
  --no-fallback \
  -H:ConfigurationFileDirectories=/home/nonroot/native-config \
  # Added because of org.apache.zookeeper.common.X509Util, org.apache.zookeeper.common.ZKConfig, javax.net.ssl.SSLContext ...
  --allow-incomplete-classpath \
  # Added because of "ClassNotFoundException: org.apache.zookeeper.server.NIOServerCnxnFactory"
  --report-unsupported-elements-at-runtime \
  # -D options from entrypoint
  -Djava.awt.headless=true \
  -Dkafka.logs.dir=/opt/kafka/bin/../logs \
  -Dlog4j.configuration=file:/etc/kafka/log4j.properties \
  -cp ${classpath} \
  -H:Name=zookeeper-server-start \
  org.apache.zookeeper.server.quorum.QuorumPeerMain \
  /home/nonroot/zookeeper-server-start

FROM gcr.io/distroless/base-debian10:nonroot@sha256:56da492c4800196c29f3e9fac3c0e66af146bfd31694f29f0958d6d568139dd9

COPY --from=0 \
  /lib/x86_64-linux-gnu/libz.so.* \
  /lib/x86_64-linux-gnu/

COPY --from=0 \
  /usr/lib/x86_64-linux-gnu/libzstd.so.* \
  /usr/lib/x86_64-linux-gnu/libsnappy.so.* \
  /usr/lib/x86_64-linux-gnu/liblz4.so.* \
  /usr/lib/x86_64-linux-gnu/

WORKDIR /usr/local
COPY --from=0 /home/nonroot/zookeeper-server-start ./bin/zookeeper-server-start.sh
COPY --from=0 /etc/kafka /etc/kafka

ENTRYPOINT [ "/usr/local/bin/zookeeper-server-start.sh" ]
CMD ["/etc/kafka/zookeeper.properties"]
