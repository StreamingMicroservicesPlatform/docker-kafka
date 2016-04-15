FROM node:5

RUN apt-get update \
  && apt-get install -y curl unzip \
  && apt-get autoremove -y \
  && apt-get clean

# Override these with your service
ENV download_zip_url "https://github.com/solsson/node-hello/archive/v1.0.1.zip"
ENV download_zip_sha256 "5d1350157e21ff5c35e309026b83e55181182a754226453f2c1a3f4a9917ad58"
ENV download_strip_dirs 1

ADD download-and-start /usr/local/bin/

ENTRYPOINT ["download-and-start"]
