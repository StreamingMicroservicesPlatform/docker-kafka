#!/bin/bash
set -e
cd /opt/cruise-control

# Override heap settings for container environments
export KAFKA_HEAP_OPTS="-XX:InitialRAMPercentage=30 -XX:MaxRAMPercentage=70 -XX:MinRAMPercentage=80"

/bin/bash ${DEBUG:+-x} /opt/cruise-control/kafka-cruise-control-start.sh /opt/cruise-control/config/cruisecontrol.properties 8090
