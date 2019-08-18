FROM gradle:4.8-jdk8-slim
ARG VERSION=2.0.61
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates
RUN git clone -b ${VERSION} https://github.com/linkedin/cruise-control.git
RUN cd cruise-control && gradle jar copyDependantLibs

RUN mv -v /home/gradle/cruise-control/cruise-control/build/libs/cruise-control-${VERSION}.jar \
  /home/gradle/cruise-control/cruise-control/build/libs/cruise-control.jar
RUN mv -v /home/gradle/cruise-control/cruise-control/build/dependant-libs/cruise-control-metrics-reporter-${VERSION}.jar \
  /home/gradle/cruise-control/cruise-control/build/dependant-libs/cruise-control-metrics-reporter.jar

FROM node:10.16
RUN mkdir /src && cd /src && git clone https://github.com/linkedin/cruise-control-ui.git
WORKDIR /src/cruise-control-ui
RUN git checkout dfc257cecb59f1be703ddb0ff3ce8522c9b3685f
RUN npm install
RUN npm run build

# The container is made to work with github.com/Yolean/kubernetes-kafka, so we try to use a common base
FROM adoptopenjdk/openjdk11:jre-11.0.4_11@sha256:140ba182d696180600a2871a98f67ad0ee2d6a1e48a7c570d1c0e156860c2a9d
ARG SOURCE_REF
ARG SOURCE_TYPE
ARG DOCKERFILE_PATH
ARG VERSION

RUN mkdir -p /opt/cruise-control /opt/cruise-control/cruise-control-ui
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/libs/cruise-control.jar /opt/cruise-control/cruise-control/build/libs/cruise-control.jar
COPY --from=0 /home/gradle/cruise-control/config /opt/cruise-control/config
COPY --from=0 /home/gradle/cruise-control/kafka-cruise-control-start.sh /opt/cruise-control/
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/dependant-libs /opt/cruise-control/cruise-control/build/dependant-libs
COPY opt/cruise-control /opt/cruise-control/
COPY --from=1 /src/cruise-control-ui/dist /opt/cruise-control/cruise-control-ui/dist
RUN echo "local,localhost,/kafkacruisecontrol" > /opt/cruise-control/cruise-control-ui/dist/static/config.csv

EXPOSE 8090
CMD [ "/opt/cruise-control/start.sh" ]
