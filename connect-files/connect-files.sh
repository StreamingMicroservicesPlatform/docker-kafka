#!/bin/bash
set -e

FILES=$($FILES_LIST_CMD)

id=0
connectors=""
for FILE in $FILES; do
  ((++id))
  echo "$id: $FILE"
  cat <<HERE > ./config/connect-file-source-$id.properties
name=local-file-source-${id}
connector.class=FileStreamSource
tasks.max=1
file=${FILE}
topic=files-000
HERE

  connectors="$connectors ./config/connect-file-source-$id.properties"
done

./bin/connect-standalone.sh ./config/worker.properties $connectors
