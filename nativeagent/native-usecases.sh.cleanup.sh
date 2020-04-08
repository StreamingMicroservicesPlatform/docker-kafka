#!/bin/bash
[ -z "$DEBUG" ] || set -x
#set -e

docker rm -f topic0
docker rm -f topic1
docker rm -f topic1-zk
docker rm -f topics-list
docker kill kafka-0
docker kill zoo-0
docker rm kafka-0
docker rm zoo-0
docker network rm native-usecases

basedir=$(pwd)/nativeagent
rm -r $basedir/configs
