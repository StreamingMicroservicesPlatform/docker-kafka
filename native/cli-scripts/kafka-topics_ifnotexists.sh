#!/bin/bash
# Utility for --create to replace --if-not-exists until that flag ceases to require zookeeper
log=$(mktemp)
kafka-topics "$@" | tee $log
result=${PIPESTATUS[0]}
grep "already exists" $log && exit 0
rm $log
exit $result
