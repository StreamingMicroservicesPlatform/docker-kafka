
FROM java:openjdk-8-jre

ENV zookeeper_version=3.4.9

RUN curl -SLs http://apache.mirrors.pair.com/zookeeper/zookeeper-$zookeeper_version/zookeeper-$zookeeper_version.tar.gz | tar -xzf - -C /opt \
  && mv /opt/zookeeper-$zookeeper_version /opt/zookeeper \
  && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
  && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
