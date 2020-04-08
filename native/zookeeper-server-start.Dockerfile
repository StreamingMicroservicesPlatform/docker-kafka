FROM solsson/kafka:nativeagent

RUN curl -L -o /home/nonroot/slf4j-simple-1.7.28.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/1.7.28/slf4j-simple-1.7.28.jar

ENTRYPOINT ["/opt/java/openjdk/bin/java" \
  , "-Xmx256M" \
  , "-server" \
  , "-XX:+UseG1GC" \
  , "-XX:MaxGCPauseMillis=20" \
  , "-XX:InitiatingHeapOccupancyPercent=35" \
  , "-XX:+ExplicitGCInvokesConcurrent" \
  , "-Djava.awt.headless=true" \
  #, "-Dcom.sun.management.jmxremote" \
  #, "-Dcom.sun.management.jmxremote.authenticate=false" \
  #, "-Dcom.sun.management.jmxremote.ssl=false" \
  , "-Dkafka.logs.dir=/opt/kafka/bin/../logs" \
  , "-Dlog4j.configuration=file:/etc/kafka/log4j.properties" \
  , "-agentpath:/opt/graalvm/lib/libnative-image-agent.so=config-merge-dir=/home/nonroot/native-config" \
  , "-cp" \
  , "/opt/kafka/libs/extensions/*:/opt/kafka/bin/../libs/activation-1.1.1.jar:/opt/kafka/bin/../libs/aopalliance-repackaged-2.5.0.jar:/opt/kafka/bin/../libs/argparse4j-0.7.0.jar:/opt/kafka/bin/../libs/audience-annotations-0.5.0.jar:/opt/kafka/bin/../libs/commons-cli-1.4.jar:/opt/kafka/bin/../libs/commons-lang3-3.8.1.jar:/opt/kafka/bin/../libs/connect-api-2.4.1.jar:/opt/kafka/bin/../libs/connect-basic-auth-extension-2.4.1.jar:/opt/kafka/bin/../libs/connect-file-2.4.1.jar:/opt/kafka/bin/../libs/connect-json-2.4.1.jar:/opt/kafka/bin/../libs/connect-mirror-2.4.1.jar:/opt/kafka/bin/../libs/connect-mirror-client-2.4.1.jar:/opt/kafka/bin/../libs/connect-runtime-2.4.1.jar:/opt/kafka/bin/../libs/connect-transforms-2.4.1.jar:/opt/kafka/bin/../libs/guava-20.0.jar:/opt/kafka/bin/../libs/hk2-api-2.5.0.jar:/opt/kafka/bin/../libs/hk2-locator-2.5.0.jar:/opt/kafka/bin/../libs/hk2-utils-2.5.0.jar:/opt/kafka/bin/../libs/jackson-annotations-2.10.0.jar:/opt/kafka/bin/../libs/jackson-core-2.10.0.jar:/opt/kafka/bin/../libs/jackson-databind-2.10.0.jar:/opt/kafka/bin/../libs/jackson-dataformat-csv-2.10.0.jar:/opt/kafka/bin/../libs/jackson-datatype-jdk8-2.10.0.jar:/opt/kafka/bin/../libs/jackson-jaxrs-base-2.10.0.jar:/opt/kafka/bin/../libs/jackson-jaxrs-json-provider-2.10.0.jar:/opt/kafka/bin/../libs/jackson-module-jaxb-annotations-2.10.0.jar:/opt/kafka/bin/../libs/jackson-module-paranamer-2.10.0.jar:/opt/kafka/bin/../libs/jackson-module-scala_2.12-2.10.0.jar:/opt/kafka/bin/../libs/jakarta.activation-api-1.2.1.jar:/opt/kafka/bin/../libs/jakarta.annotation-api-1.3.4.jar:/opt/kafka/bin/../libs/jakarta.inject-2.5.0.jar:/opt/kafka/bin/../libs/jakarta.ws.rs-api-2.1.5.jar:/opt/kafka/bin/../libs/jakarta.xml.bind-api-2.3.2.jar:/opt/kafka/bin/../libs/javassist-3.22.0-CR2.jar:/opt/kafka/bin/../libs/javax.servlet-api-3.1.0.jar:/opt/kafka/bin/../libs/javax.ws.rs-api-2.1.1.jar:/opt/kafka/bin/../libs/jaxb-api-2.3.0.jar:/opt/kafka/bin/../libs/jersey-client-2.28.jar:/opt/kafka/bin/../libs/jersey-common-2.28.jar:/opt/kafka/bin/../libs/jersey-container-servlet-2.28.jar:/opt/kafka/bin/../libs/jersey-container-servlet-core-2.28.jar:/opt/kafka/bin/../libs/jersey-hk2-2.28.jar:/opt/kafka/bin/../libs/jersey-media-jaxb-2.28.jar:/opt/kafka/bin/../libs/jersey-server-2.28.jar:/opt/kafka/bin/../libs/jetty-client-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-continuation-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-http-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-io-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-security-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-server-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-servlet-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-servlets-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jetty-util-9.4.20.v20190813.jar:/opt/kafka/bin/../libs/jopt-simple-5.0.4.jar:/opt/kafka/bin/../libs/kafka_2.12-2.4.1.jar:/opt/kafka/bin/../libs/kafka_2.12-2.4.1-sources.jar:/opt/kafka/bin/../libs/kafka-clients-2.4.1.jar:/opt/kafka/bin/../libs/kafka-log4j-appender-2.4.1.jar:/opt/kafka/bin/../libs/kafka-streams-2.4.1.jar:/opt/kafka/bin/../libs/kafka-streams-examples-2.4.1.jar:/opt/kafka/bin/../libs/kafka-streams-scala_2.12-2.4.1.jar:/opt/kafka/bin/../libs/kafka-streams-test-utils-2.4.1.jar:/opt/kafka/bin/../libs/kafka-tools-2.4.1.jar:/opt/kafka/bin/../libs/log4j-1.2.17.jar:/opt/kafka/bin/../libs/lz4-java-1.6.0.jar:/opt/kafka/bin/../libs/maven-artifact-3.6.1.jar:/opt/kafka/bin/../libs/metrics-core-2.2.0.jar:/opt/kafka/bin/../libs/netty-buffer-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-codec-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-common-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-handler-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-resolver-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-transport-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-transport-native-epoll-4.1.45.Final.jar:/opt/kafka/bin/../libs/netty-transport-native-unix-common-4.1.45.Final.jar:/opt/kafka/bin/../libs/osgi-resource-locator-1.0.1.jar:/opt/kafka/bin/../libs/paranamer-2.8.jar:/opt/kafka/bin/../libs/plexus-utils-3.2.0.jar:/opt/kafka/bin/../libs/reflections-0.9.11.jar:/opt/kafka/bin/../libs/rocksdbjni-5.18.3.jar:/opt/kafka/bin/../libs/scala-collection-compat_2.12-2.1.2.jar:/opt/kafka/bin/../libs/scala-java8-compat_2.12-0.9.0.jar:/opt/kafka/bin/../libs/scala-library-2.12.10.jar:/opt/kafka/bin/../libs/scala-logging_2.12-3.9.2.jar:/opt/kafka/bin/../libs/scala-reflect-2.12.10.jar:/opt/kafka/bin/../libs/slf4j-api-1.7.28.jar:/opt/kafka/bin/../libs/slf4j-log4j12-1.7.28.jar:/opt/kafka/bin/../libs/snappy-java-1.1.7.3.jar:/opt/kafka/bin/../libs/validation-api-2.0.1.Final.jar:/opt/kafka/bin/../libs/zookeeper-3.5.7.jar:/opt/kafka/bin/../libs/zookeeper-jute-3.5.7.jar:/opt/kafka/bin/../libs/zstd-jni-1.4.3-1.jar" \
  , "kafka.admin.TopicCommand"]

# TODO extract from entrypoint
ARG classpath=/home/nonroot/slf4j-simple-1.7.28.jar:/opt/kafka/bin/../libs/slf4j-api-1.7.28.jar:/opt/kafka/bin/../libs/zookeeper-3.5.7.jar:/opt/kafka/bin/../libs/zookeeper-jute-3.5.7.jar

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
