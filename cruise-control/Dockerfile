FROM gradle:4.8-jdk8-slim
ARG VERSION=2.0.18
USER root
RUN apt-get update && apt-get install -y git
RUN git clone -b ${VERSION} https://github.com/linkedin/cruise-control.git
RUN cd cruise-control && gradle jar copyDependantLibs
RUN ls -l /home/gradle/cruise-control/cruise-control/build/libs/

# The container is made to work with github.com/Yolean/kubernetes-kafka, so we try to use a common base
FROM solsson/jdk-opensource:11.0.1@sha256:740feb6c1ecbdf2beac1dc41405c3215511b90d83a7211f805e88f92946dd2a9
ARG SOURCE_REF
ARG SOURCE_TYPE
ARG DOCKERFILE_PATH
ARG VERSION=2.0.18

RUN mkdir -p /opt/cruise-control
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/libs/cruise-control-${VERSION}.jar /opt/cruise-control/cruise-control/build/libs/cruise-control.jar
COPY --from=0 /home/gradle/cruise-control/config /opt/cruise-control/config
COPY --from=0 /home/gradle/cruise-control/kafka-cruise-control-start.sh /opt/cruise-control/
COPY --from=0 /home/gradle/cruise-control/cruise-control/build/dependant-libs /opt/cruise-control/cruise-control/build/dependant-libs
COPY opt/cruise-control /opt/cruise-control/

EXPOSE 8090
CMD [ "/opt/cruise-control/start.sh" ]
