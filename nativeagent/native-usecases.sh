#!/bin/bash
[ -z "$DEBUG" ] || set -x
set -e

basedir=$(pwd)/nativeagent
mkdir $basedir/configs

function configvolume {
  entrypoint=$1
  dir=$basedir/configs/$entrypoint
  [ -d $dir ] || mkdir $dir
  echo '[]' > $dir/jni-config.json
  echo '[]' > $dir/reflect-config.json
  echo '[]' > $dir/proxy-config.json
  echo '{}' > $dir/resource-config.json
  chmod a+w $dir/*
  echo $dir
}

docker network create native-usecases

docker run -d --network="native-usecases" -v $(configvolume zooekeeper-server-start):/home/nonroot/native-config \
  --name zoo-0 --expose=2181 solsson/kafka:zookeeper-server-start-nativeagent

sleep 1

docker run -d --network="native-usecases" -v $(configvolume kafka-server-start):/home/nonroot/native-config \
  --name kafka-0 --expose=9092 solsson/kafka:kafka-server-start-nativeagent \
  /etc/kafka/server.properties \
  --override zookeeper.connect=zoo-0:2181

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic0 solsson/kafka:kafka-topics-nativeagent \
  --bootstrap-server kafka-0:9092 \
  --create --topic topic0

until docker logs kafka-0 | grep 'Kafka startTimeMs:'; do
  echo "Waiting for Kafka start ..."
  sleep 1
done

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic1 solsson/kafka:kafka-topics-nativeagent \
  --bootstrap-server kafka-0:9092 \
  --create --topic topic1

docker run --network="native-usecases" -v $(configvolume kafka-topics):/home/nonroot/native-config \
  --name topic1-zk solsson/kafka:kafka-topics-nativeagent \
  --zookeeper zoo-0:2181 \
  --create --topic topic1 --partitions 1 --replication-factor 1 --if-not-exists

docker exec kafka-0 kill -s TERM 1
docker exec zoo-0 kill -s TERM 1

docker network rm native-usecases
