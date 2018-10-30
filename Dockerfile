FROM gradle:4.8-jdk8-slim
ARG VERSION=2.0.6
USER root
RUN apt-get update && apt-get install -y git
RUN git clone -b ${VERSION} https://github.com/linkedin/cruise-control.git
RUN cd cruise-control && gradle jar copyDependantLibs

# The container is made to work with github.com/Yolean/kubernetes-kafka, so we try to use a common base
FROM solsson/kafka-jre:8@sha256:1ebc3c27c30f5925d240aaa0858e111c2fa6d358048b0f488860ea9cd9c84822
ARG SOURCE_REF
ARG SOURCE_TYPE
ARG DOCKERFILE_PATH
ARG VERSION=2.0.6

RUN mkdir -p /opt/cruise-control
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/libs/cruise-control-${VERSION}.jar /opt/cruise-control/cruise-control/build/libs/cruise-control.jar
COPY --from=0 /home/gradle/cruise-control/config /opt/cruise-control/config
COPY --from=0 /home/gradle/cruise-control/kafka-cruise-control-start.sh /opt/cruise-control/
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/dependant-libs /opt/cruise-control/cruise-control/build/dependant-libs
COPY opt/cruise-control /opt/cruise-control/

EXPOSE 8090
CMD [ "/opt/cruise-control/start.sh" ]
