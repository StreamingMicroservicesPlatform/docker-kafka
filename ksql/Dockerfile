FROM solsson/kafka-jre@sha256:61196845eafb0970cf94598fd723a66407be31cd8bab83e3a29b4e602683280d

ENV ksql_version=dc1ad22e95793252c47f2a66656417e64e0fec21 ksql_repo=https://github.com/confluentinc/ksql

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
  mkdir -p /opt/src/ksql; cd /opt/src/ksql; \
  curl -SLs ${ksql_repo}/archive/${ksql_version}.tar.gz | tar -xzf - --strip-components=1 -C ./; \
  mvn package; \
  \
  cd $WORKDIR; \
  \
  echo "TODO cleanup, but for now we just want a ksql build to experiment with, and possibly re-build";

RUN echo "cont'd at temp layer boundary"; set -ex; \
  cd /opt/src/ksql; \
  find . -name *-package; \
  cat ksql-examples/Dockerfile