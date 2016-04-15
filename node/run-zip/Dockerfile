FROM node:5

# Override these with your service
ENV download_zip_url "https://github.com/solsson/node-hello/archive/v1.0.0.zip"
ENV download_zip_sha256 "d59981b1f0b5ff99419a1e8a5df23da420d2d30647187240b8db4a47daeffd06"
ENV download_strip_dirs 1

RUN apt-get update \
  && apt-get install -y curl unzip \
  && apt-get autoremove -y \
  && apt-get clean

ADD download-and-start /usr/local/bin/

ENTRYPOINT ["download-and-start"]
