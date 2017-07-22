# Kafka docker builds

Automated [Kafka](http://kafka.apache.org/) builds for https://hub.docker.com/r/solsson/kafka/
and related `kafka-` images under https://hub.docker.com/u/solsson/.

---

This repo used to contain misc dockerfiles, but they've moved to separate repositories for dockerization projects.
We've kept the repository name to avoid breaking the automated build of solsson/kafka in Docker Hub.

For legacy Dockerfiles from this repo (if you navigated to here from a Docker Hub [solsson](https://hub.docker.com/u/solsson/) image),
see https://github.com/solsson/dockerfiles/tree/misc-dockerfiles.

---

Our kafka images are tested in production with https://github.com/Yolean/kubernetes-kafka/.

You most likely need to mount your own config files, or for `./bin/kafka-server-start.sh` use overrides like:
```
  --override zookeeper.connect=zookeeper:2181
  --override log.dirs=/var/lib/kafka/data/topics
  --override log.retention.hours=-1
  --override broker.id=0
  --override advertised.listener=PLAINTEXT://kafka-0:9092
```

## One image to rule them all

Official [Kafka distributions](http://kafka.apache.org/downloads) contain startup scripts and config for various services and clients. Thus `./kafka` produces a multi-purpose image for direct use and specialized docker builds.

We could build specialized images like `kafka-server` but we have two reasons not to:
 * Won't be as transparent in Docker Hub because you can't use Automated Build without scripting.
 * In reality you'll need to control your own config anyway.

### Example of downstream image: Kafka Connect

See ./connect-jmx

### Example downstream image: Kafka Streams

TODO

## Building

Rudimentary compliance with kubernetes-kafka is tested using a [build-contract](https://github.com/Yolean/build-contract/).

Build and test using: `docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/:/source solsson/build-contract test`

To keep kafka running for local use, uncomment `ports` 9092 and run: `docker-compose -f build-contracts/docker-compose.yml up --force-recreate`.

While timing issues remain, start services individually...

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
