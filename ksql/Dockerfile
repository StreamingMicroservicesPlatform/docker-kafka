FROM solsson/kafka-jre@sha256:61196845eafb0970cf94598fd723a66407be31cd8bab83e3a29b4e602683280d

ENV ksql_version=dc1ad22e95793252c47f2a66656417e64e0fec21 ksql_repo=https://github.com/confluentinc/ksql

ENV CP_VERSION=3.3.0
ENV KSQL_BUILD=0.1-SNAPSHOT

WORKDIR /usr/local

RUN set -ex; \
  WORKDIR=$PWD; \
  mkdir -p $WORKDIR/share/java; \
  \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  MAVEN_VERSION=3.5.0 PATH=$PATH:/opt/maven/bin; \
  mkdir -p /opt/maven; \
  curl -SLs https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -xzf - --strip-components=1 -C /opt/maven; \
  mvn --version; \
  \
  mkdir -p /opt/src/common; cd /opt/src/common; \
  curl -SLs https://github.com/confluentinc/common/archive/v$CP_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn install; \
  \
  mkdir -p /opt/src/rest-utils; cd /opt/src/rest-utils; \
  curl -SLs https://github.com/confluentinc/rest-utils/archive/v$CP_VERSION.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn install; \
  \
  mkdir -p /opt/src/ksql; cd /opt/src/ksql; \
  curl -SLs ${ksql_repo}/archive/${ksql_version}.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn package; \
  \
  cd $WORKDIR; \
  \
  mv /opt/src/common/package/target/common-package-$CP_VERSION-package/share/java/confluent-common ./share/java/; \
  mv /opt/src/rest-utils/package/target/rest-utils-package-$CP_VERSION-package/share/java/rest-utils ./share/java/; \
  \
  mv /opt/src/ksql/ksql-rest-app/target/ksql-rest-app-${KSQL_BUILD}-package/etc/ksql-rest-app /etc/; \
  mv /opt/src/ksql/ksql-rest-app/target/ksql-rest-app-${KSQL_BUILD}-package/bin/* ./bin/; \
  mv /opt/src/ksql/ksql-rest-app/target/ksql-rest-app-${KSQL_BUILD}-package/share/java/ksql-rest-app ./share/java/; \
  \
  #mv /opt/src/ksql/ksql-examples/target/ksql-examples-${KSQL_BUILD}-package/share/java/ksql-examples ./share/java/; \
  #mv /opt/src/ksql/ksql-cli/target/ksql-cli-${KSQL_BUILD}-package/share/java/ksql-cli ./share/java/; \
  \
  rm -Rf /opt/src /opt/maven /root/.m2; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

ENTRYPOINT ["ksql-server-start"]
CMD ["/etc/ksql-rest-app/ksqlserver.properties"]
