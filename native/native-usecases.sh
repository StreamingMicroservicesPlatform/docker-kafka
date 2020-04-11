#!/bin/bash
[ -z "$DEBUG" ] || set -x
set -e

basedir="$(dirname $0)"
compose="docker-compose -f $basedir/docker-compose.yml"

# Clean up existing native-image config to get fresh results
[ ! -z "$CLEANUP" ] || CLEANUP="
  zookeeper-server-start
  kafka-server-start
  kafka-topics
"

for entrypoint in $CLEANUP; do
  dir=$basedir/configs/$entrypoint
  echo '[]' > $dir/jni-config.json
  echo '[]' > $dir/reflect-config.json
  echo '[]' > $dir/proxy-config.json
  echo '{}' > $dir/resource-config.json
  [ ! -d $basedir/configs-manual-additions/$entrypoint ] || \
    cp $basedir/configs-manual-additions/$entrypoint/* $dir/
  chmod a+w $dir/*
done

$compose up -d zoo-0
$compose up -d zoo-1
$compose up -d zoo-2
sleep 5
$compose up -d kafka-0
$compose up -d kafkacat
$compose ps

for step in $(seq 1 3); do
  $compose up step$step
done
