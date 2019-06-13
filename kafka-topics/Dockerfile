FROM solsson/curl@sha256:92ebf15ac57bea360484480336ed5d9fa16d38d773fd00f7e9fb2cae94baf25a as slf4j-impl

RUN curl -o /slf4j-simple-1.7.25.jar http://central.maven.org/maven2/org/slf4j/slf4j-simple/1.7.25/slf4j-simple-1.7.25.jar


FROM solsson/kafka@sha256:9f1f0e769cd10e0503bc5649f9fcb0fc2c28aaf8e3b9b30ef2e6da67655bb3f6 as dist

# The rest can be generated from:
#docker run --rm --entrypoint sleep --name kafkaimage -d [the FROM above] infinity
#docker exec -ti kafkaimage sed -i 's/exec/echo exec/' bin/kafka-run-class.sh
#docker exec -ti kafkaimage ./bin/kafka-topics.sh args-go-here | sed 's|/opt/kafka/bin/../libs/|./libs/|g'

COPY --from=slf4j-impl /slf4j-simple-1.7.25.jar /opt/kafka/libs/slf4j-simple-1.7.25.jar

#ENTRYPOINT [ "/opt/java/openjdk/bin/java", "-cp", "./libs/activation-1.1.1.jar:./libs/aopalliance-repackaged-2.5.0-b42.jar:./libs/argparse4j-0.7.0.jar:./libs/audience-annotations-0.5.0.jar:./libs/commons-lang3-3.8.1.jar:./libs/connect-api-2.2.1.jar:./libs/connect-basic-auth-extension-2.2.1.jar:./libs/connect-file-2.2.1.jar:./libs/connect-json-2.2.1.jar:./libs/connect-runtime-2.2.1.jar:./libs/connect-transforms-2.2.1.jar:./libs/guava-20.0.jar:./libs/hk2-api-2.5.0-b42.jar:./libs/hk2-locator-2.5.0-b42.jar:./libs/hk2-utils-2.5.0-b42.jar:./libs/jackson-annotations-2.9.8.jar:./libs/jackson-core-2.9.8.jar:./libs/jackson-databind-2.9.8.jar:./libs/jackson-datatype-jdk8-2.9.8.jar:./libs/jackson-jaxrs-base-2.9.8.jar:./libs/jackson-jaxrs-json-provider-2.9.8.jar:./libs/jackson-module-jaxb-annotations-2.9.8.jar:./libs/javassist-3.22.0-CR2.jar:./libs/javax.annotation-api-1.2.jar:./libs/javax.inject-1.jar:./libs/javax.inject-2.5.0-b42.jar:./libs/javax.servlet-api-3.1.0.jar:./libs/javax.ws.rs-api-2.1.1.jar:./libs/javax.ws.rs-api-2.1.jar:./libs/jaxb-api-2.3.0.jar:./libs/jersey-client-2.27.jar:./libs/jersey-common-2.27.jar:./libs/jersey-container-servlet-2.27.jar:./libs/jersey-container-servlet-core-2.27.jar:./libs/jersey-hk2-2.27.jar:./libs/jersey-media-jaxb-2.27.jar:./libs/jersey-server-2.27.jar:./libs/jetty-client-9.4.14.v20181114.jar:./libs/jetty-continuation-9.4.14.v20181114.jar:./libs/jetty-http-9.4.14.v20181114.jar:./libs/jetty-io-9.4.14.v20181114.jar:./libs/jetty-security-9.4.14.v20181114.jar:./libs/jetty-server-9.4.14.v20181114.jar:./libs/jetty-servlet-9.4.14.v20181114.jar:./libs/jetty-servlets-9.4.14.v20181114.jar:./libs/jetty-util-9.4.14.v20181114.jar:./libs/jopt-simple-5.0.4.jar:./libs/kafka_2.12-2.2.1.jar:./libs/kafka_2.12-2.2.1-sources.jar:./libs/kafka-clients-2.2.1.jar:./libs/kafka-log4j-appender-2.2.1.jar:./libs/kafka-streams-2.2.1.jar:./libs/kafka-streams-examples-2.2.1.jar:./libs/kafka-streams-scala_2.12-2.2.1.jar:./libs/kafka-streams-test-utils-2.2.1.jar:./libs/kafka-tools-2.2.1.jar:./libs/log4j-1.2.17.jar:./libs/lz4-java-1.5.0.jar:./libs/maven-artifact-3.6.0.jar:./libs/metrics-core-2.2.0.jar:./libs/osgi-resource-locator-1.0.1.jar:./libs/plexus-utils-3.1.0.jar:./libs/reflections-0.9.11.jar:./libs/rocksdbjni-5.15.10.jar:./libs/scala-library-2.12.8.jar:./libs/scala-logging_2.12-3.9.0.jar:./libs/scala-reflect-2.12.8.jar:./libs/slf4j-api-1.7.25.jar:./libs/slf4j-log4j12-1.7.25.jar:./libs/snappy-java-1.1.7.2.jar:./libs/validation-api-1.1.0.Final.jar:./libs/zkclient-0.11.jar:./libs/zookeeper-3.4.13.jar:./libs/zstd-jni-1.3.8-1.jar" ]
ENTRYPOINT [ "/opt/java/openjdk/bin/java", "-cp", "./libs/kafka_2.12-2.2.1.jar:./libs/kafka-clients-2.2.1.jar:./libs/scala-library-2.12.8.jar:./libs/scala-logging_2.12-3.9.0.jar:./libs/slf4j-api-1.7.25.jar:./libs/jopt-simple-5.0.4.jar:./libs/slf4j-simple-1.7.25.jar:./libs/zookeeper-3.4.13.jar:./libs/metrics-core-2.2.0.jar:./libs/jackson-core-2.9.8.jar:./libs/jackson-databind-2.9.8.jar:./libs/jackson-annotations-2.9.8.jar:./libs/zkclient-0.11.jar" ]
CMD ["kafka.admin.TopicCommand"]

FROM oracle/graalvm-ce:19.0.0@sha256:71d4990f47e9b2300c57775e1306af477232019b624376c8f120d910caedb4b4 as native-build
RUN gu install native-image

COPY --from=dist /opt/kafka /opt/kafka

RUN  cd /opt/kafka && native-image \
  #--report-unsupported-elements-at-runtime \
  --no-server \
  -cp ./libs/kafka_2.12-2.2.1.jar:./libs/kafka-clients-2.2.1.jar:./libs/scala-library-2.12.8.jar:./libs/scala-logging_2.12-3.9.0.jar:./libs/slf4j-api-1.7.25.jar:./libs/jopt-simple-5.0.4.jar:./libs/slf4j-simple-1.7.25.jar:./libs/zookeeper-3.4.13.jar:./libs/metrics-core-2.2.0.jar:./libs/jackson-core-2.9.8.jar:./libs/jackson-databind-2.9.8.jar:./libs/jackson-annotations-2.9.8.jar:./libs/zkclient-0.11.jar:./libs/log4j-1.2.17.jar:./libs/lz4-java-1.5.0.jar \
  kafka.admin.TopicCommand

#FROM scratch
# See errors from native-image command
FROM solsson/kafka@sha256:9f1f0e769cd10e0503bc5649f9fcb0fc2c28aaf8e3b9b30ef2e6da67655bb3f6

COPY --from=native-build /opt/kafka/kafka.admin.topiccommand /opt/kafka/kafka.admin.topiccommand

ENTRYPOINT [ "/opt/kafka/kafka.admin.topiccommand" ]
