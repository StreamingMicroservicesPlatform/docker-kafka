
FROM node:5

RUN npm install -g js-yaml \
  && npm cache clean

USER daemon

# assumes that default is kept in config.yaml
EXPOSE 4873

# this is also just a recommendation, config file decides
VOLUME /sinopia

ENTRYPOINT ["sinopia", "-c", "/sinopia/config.yaml"]
