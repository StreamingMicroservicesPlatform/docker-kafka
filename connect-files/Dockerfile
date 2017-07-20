FROM solsson/kafka:0.11.0.0

COPY worker.properties ./config/
COPY connect-file-source.properties.template
COPY connect-files.sh ./bin/

ENV FILES_LIST_CMD="find /logs/ -name *.log"
