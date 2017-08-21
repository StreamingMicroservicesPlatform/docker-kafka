FROM solsson/kafka@sha256:b27560de08d30ebf96d12e74f80afcaca503ad4ca3103e63b1fd43a2e4c976ce

ENV CP_VERSION=3.3.0

WORKDIR /usr/local

ADD pom.xml .

RUN set -ex; \
  WORKDIR=$PWD; \
  mkdir -p $WORKDIR/share/java; \
  \
  # avoid patching kafka-run-class.sh, by hijacking one of the paths where it globs for jars
  JARS_DIR=$WORKDIR/share/java; \
  mkdir -p /opt/kafka/core/build; \
  ln -s $JARS_DIR /opt/kafka/core/build/dependant-libs-${SCALA_VERSION}; \
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
  mvn dependency:copy-dependencies -DincludeScope=runtime -DoutputDirectory=$JARS_DIR; \
  \
  rm -Rf /opt/src /opt/maven /root/.m2; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

#COPY docker-help.sh /usr/local/bin/docker-help
#ENTRYPOINT ["docker-help"]
