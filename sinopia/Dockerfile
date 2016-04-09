# Assumes you'll mount volume(s) for config and storage,
# and set env to point to config.yaml

FROM node:5

RUN npm install -g js-yaml sinopia

ENV config=/etc/sinopia/config.yaml

ENTRYPOINT ["sinopia", "-c", "$config"]
