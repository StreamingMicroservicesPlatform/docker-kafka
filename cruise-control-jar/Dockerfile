FROM alpine:3.8

RUN apk add --no-cache curl

ENV VERSION=2.0.17

RUN curl -fsL -o /cruise-control-metrics-reporter.jar https://linkedin.jfrog.io/linkedin/cruise-control/com/linkedin/cruisecontrol/cruise-control-metrics-reporter/${VERSION}/cruise-control-metrics-reporter-${VERSION}.jar

FROM busybox

COPY --from=0 /cruise-control-metrics-reporter.jar /cruise-control-metrics-reporter.jar
