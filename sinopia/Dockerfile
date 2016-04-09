
FROM node:5

RUN npm install -g js-yaml sinopia

USER sinopia

ENTRYPOINT ["sinopia", "-c", "/etc/sinopia/config.yaml"]
