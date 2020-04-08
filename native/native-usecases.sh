#!/bin/bash
[ -z "$DEBUG" ] || set -x
set -e

basedir=$(pwd)/native
[ ! -d $basedir/configs ] || echo "Try ./native/native-usecases.sh.cleanup.sh on failure"
mkdir $basedir/configs

function configvolume {
  entrypoint=$1
  dir=$basedir/configs/$entrypoint
  [ -d $dir ] || {
    mkdir $dir
    echo '[]' > $dir/jni-config.json
    echo '[]' > $dir/reflect-config.json
    echo '[]' > $dir/proxy-config.json
    echo '{}' > $dir/resource-config.json
    [ ! -d $basedir/configs-manual-additions/$entrypoint ] || \
      cp $basedir/configs-manual-additions/$entrypoint/* $dir/
    chmod a+w $dir/*
  }
  echo $dir
}

docker network create native-usecases

docker run -d --network="native-usecases" -v $(configvolume zookeeper-server-start):/home/nonroot/native-config \
  --name zoo-0 --expose=2181 solsson/kafka:nativeagent-zookeeper-server-start

sleep 1

docker run -d --network="native-usecases" -v $(configvolume kafka-server-start):/home/nonroot/native-config \
  --name kafka-0 --expose=9092 solsson/kafka:nativeagent-kafka-server-start \
  /etc/kafka/server.properties \
  --override zookeeper.connect=zoo-0:2181

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic0 solsson/kafka:nativeagent-kafka-topics \
  --bootstrap-server kafka-0:9092 \
  --create --topic topic0

until docker logs kafka-0 | grep 'Kafka startTimeMs:'; do
  echo "Waiting for Kafka start ..."
  sleep 1
done

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic1 solsson/kafka:nativeagent-kafka-topics \
  --bootstrap-server kafka-0:9092 \
  --create --topic topic1

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic1-zk solsson/kafka:nativeagent-kafka-topics \
  --zookeeper zoo-0:2181 \
  --create --topic topic1 --partitions 1 --replication-factor 1 --if-not-exists

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topics-list solsson/kafka:nativeagent-kafka-topics \
  --bootstrap-server kafka-0:9092 \
  --list | grep topic1

docker exec kafka-0 kill -s TERM 1
docker exec zoo-0 kill -s TERM 1

sleep 10 # or wait for containers to exit, maybe we could us a label

docker network rm native-usecases
