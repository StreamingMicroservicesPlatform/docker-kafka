
FROM java:openjdk-8-jre

ENV zookeeper_version=3.4.8

RUN buildDeps=' \
		ca-certificates \
		curl \
  ' \
  && apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
  && rm -r /var/lib/apt/lists/* \
  && curl -SLs http://apache.mirrors.pair.com/zookeeper/zookeeper-$zookeeper_version/zookeeper-$zookeeper_version.tar.gz | tar -xzf - -C /opt \
  && apt-get purge -y --auto-remove $buildDeps \
  && mv /opt/zookeeper-$zookeeper_version /opt/zookeeper \
  && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
  && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
