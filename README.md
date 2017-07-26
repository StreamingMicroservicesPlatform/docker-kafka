# Kafka docker builds

The no-surprises Kafka docker image. Public build at [solsson/kafka](https://hub.docker.com/r/solsson/kafka/), with 100k+ pulls to date.

Design goals:
 * Transparent build: self-contained in Dockerfile && directly from source.
 * Recommend use of image SHAs for security and stability ([#11](https://github.com/solsson/dockerfiles/pull/11)).
 * Same basic platform choices as the more [thoroughly validated](https://www.confluent.io/blog/exactly-once-semantics-are-possible-heres-how-apache-kafka-does-it/) [Confluent Platform distribution](https://hub.docker.com/r/confluentinc/cp-kafka/) ([#5](https://github.com/solsson/dockerfiles/pull/5), [#9](https://github.com/solsson/dockerfiles/pull/9)).
 * Supports the other tools bundled with Kafka distributions - Zookeeper, topic admin, Connect & Streams ([#7](https://github.com/solsson/dockerfiles/pull/7)).
 * Encourage conventions to clearly show all non-default config, to help Kafka beginners.
 * Avoid recommending [--net=host](http://docs.confluent.io/current/cp-docker-images/docs/quickstart.html) as such practices are impractical in multi-node environments.
 * Support [Kubernetes](http://kubernetes.io); transparent and tweakable cluster setups like [Yolean/kubernetes-kafka](https://github.com/Yolean/kubernetes-kafka).

## How to use

The default entrypoint `docker run solsson/kafka` will list "bin" scripts and sample config files. Make a guess like `docker run --entrypoint ./bin/kafka-server-start.sh solsson/kafka` or `docker run --entrypoint ./bin/kafka-topics.sh solsson/kafka` to see tool-specific help.

You most likely need to mount your own config files, or for `./bin/kafka-server-start.sh` use overrides like:
```
  --override zookeeper.connect=zookeeper:2181
  --override log.dirs=/var/lib/kafka/data/topics
  --override log.retention.hours=-1
  --override broker.id=0
  --override advertised.listener=PLAINTEXT://kafka-0:9092
```

Beware of `log4j.properties`' location if you mount config. Kafka's bin scripts will guess path unless you set a `KAFKA_LOG4J_OPTS` env.

We avoid environment variable rules for config override, used in [wurstmeister](https://hub.docker.com/r/wurstmeister/kafka/) and [cp-kafka](https://hub.docker.com/r/confluentinc/cp-kafka/), because bin scripts are quite heavy on env use anyway so you'd get a toxic mix. Also for cluster setups to share config across instances we tend to need bash tricks. See for example [this gotcha](https://github.com/Yolean/kubernetes-kafka/pull/45/commits/db264b09cc7903346238b4464183f3a9571f65e6) and the overrides needed for  [external access](https://github.com/Yolean/kubernetes-kafka/issues/13).

## Upgrade from pre 0.11 images

Earlier images used `./bin/kafka-server-start.sh` as entrypoint
and had the `zookeeper.connect=zookeeper:2181` (instead of localhost:2181) built in. At upgrade use the command recommended above to restore that functionality.

## Build and test locally

To build your own kafka image simply run `docker build ./kafka`.

When we develop locally --- stream processing images, monitoring,
compliance with kubernetes-kafka etc ---
we use a [build-contract](https://github.com/Yolean/build-contract/).

Build and test using: `docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/:/source solsson/build-contract test`. However... while timing issues remain you need some manual intervention:

```bash
compose='docker-compose -f build-contracts/docker-compose.yml'
$compose up -d zookeeper kafka-0
$compose logs zookeeper kafka-0
# can we create topics using the image's provided script?
$compose up test-topic-create-1
# can a producer send messages using snappy (has issues before with a class missing in the image)
$compose up test-snappy-compression
$compose up test-consume-all
# demo the log/file aggregation image
docker-compose -f build-contracts/docker-compose.files-aggregation.yml up
# demo the JMX->kafka image
docker-compose -f build-contracts/docker-compose.monitoring.yml up
```

## Why is the repo named `dockerfiles`?

This repo used to contain misc dockerfiles, but they've moved to separate repositories for dockerization projects.
We've kept the repository name to avoid breaking the automated build of solsson/kafka in Docker Hub.

For legacy Dockerfiles from this repo (if you navigated to here from a Docker Hub [solsson](https://hub.docker.com/u/solsson/) image),
see https://github.com/solsson/dockerfiles/tree/misc-dockerfiles.
