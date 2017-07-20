# dockerfiles

Nowadays we're using separate repositories for dockerization projects.

For legacy Dockerfiles from this repo (if you navigated to here from a Docker Hub [solsson](https://hub.docker.com/u/solsson/) image),
see https://github.com/solsson/dockerfiles/tree/misc-dockerfiles.

# Kafka docker builds

This repository maintains automated [Kafka](http://kafka.apache.org/) builds for https://hub.docker.com/r/solsson/kafka/
and related `kafka-` images under https://hub.docker.com/u/solsson/.

These images are tested in production with https://github.com/Yolean/kubernetes-kafka/.

## Building

Rudimentary compliance with kubernetes-kafka is tested using a [build-contract](https://github.com/Yolean/build-contract/).

Build and test using: `docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/:/source solsson/build-contract test`

To keep kafka running for local use, uncomment `ports` 9092 and run: `docker-compose -f build-contracts/docker-compose.yml`.
