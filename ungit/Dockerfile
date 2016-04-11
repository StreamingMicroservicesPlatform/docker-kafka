FROM node:5

RUN apt-get update \
  && apt-get install -y git \
  && rm -r /var/lib/apt/lists/*

RUN npm install ungit -g

EXPOSE 8448

ENTRYPOINT ["/usr/bin/ungit", "--no-launchBrowser"]
