FROM adoptopenjdk:11.0.7_10-jdk-hotspot-bionic@sha256:c2ce12d7530d957f2d44dd33339eeeafa3b889c27af0824b186c4afef1f843ef \
  as nonlibs
RUN echo "class Empty {public static void main(String[] a){}}" > Empty.java && javac Empty.java && jar --create --file /empty.jar Empty.class

FROM curlimages/curl@sha256:aa45e9d93122a3cfdf8d7de272e2798ea63733eeee6d06bd2ee4f2f8c4027d7c \
  as extralibs

USER root
RUN curl -L -o /slf4j-simple-1.7.30.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/1.7.30/slf4j-simple-1.7.30.jar
RUN curl -L -o /quarkus-kafka-client-1.4.2.Final.jar https://repo1.maven.org/maven2/io/quarkus/quarkus-kafka-client/1.4.2.Final/quarkus-kafka-client-1.4.2.Final.jar

FROM solsson/kafka:nativebase as native

ARG classpath=/opt/kafka/libs/extensions/*:/opt/kafka/libs/*

COPY --from=extralibs /*.jar /opt/kafka/libs/extensions/

# docker run --rm --entrypoint ls solsson/kafka -l /opt/kafka/libs/ | grep log
COPY --from=nonlibs /empty.jar /opt/kafka/libs/slf4j-log4j12-1.7.30.jar
COPY --from=nonlibs /empty.jar /opt/kafka/libs/log4j-1.2.17.jar

COPY configs/kafka-topics /home/nonroot/native-config

RUN native-image \
  --no-server \
  -H:+ReportExceptionStackTraces \
  --no-fallback \
  -H:IncludeResourceBundles=joptsimple.HelpFormatterMessages \
  -H:IncludeResourceBundles=joptsimple.ExceptionMessages \
  -H:ConfigurationFileDirectories=/home/nonroot/native-config \
  # Added because of "Invoke with MethodHandle argument ..."
  --report-unsupported-elements-at-runtime \
  # -D options from entrypoint
  -Djava.awt.headless=true \
  -Dkafka.logs.dir=/opt/kafka/bin/../logs \
  -cp ${classpath} \
  -H:Name=kafka-topics \
  kafka.admin.TopicCommand \
  /home/nonroot/kafka-topics

FROM gcr.io/distroless/base-debian10:nonroot@sha256:26abe8d89163131be2a159a9d8082e921387f196127f42ce77fb96420dbecf88

COPY --from=0 \
  /lib/x86_64-linux-gnu/libz.so.* \
  /lib/x86_64-linux-gnu/

COPY --from=0 \
  /usr/lib/x86_64-linux-gnu/libzstd.so.* \
  /usr/lib/x86_64-linux-gnu/libsnappy.so.* \
  /usr/lib/x86_64-linux-gnu/liblz4.so.* \
  /usr/lib/x86_64-linux-gnu/

WORKDIR /usr/local
COPY --from=native /home/nonroot/kafka-topics ./bin/kafka-topics.sh

ENTRYPOINT [ "/usr/local/bin/kafka-topics.sh" ]
