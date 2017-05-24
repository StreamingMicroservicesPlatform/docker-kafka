FROM node:7.10@sha256:4b28451edc9d0f45152f38780a7eea2461fa54fb7df1ae47c9830592d90cc8bb

RUN apt-get update \
  && apt-get install -y curl unzip \
  && apt-get autoremove -y \
  && apt-get clean

# Override these with your service
ENV download_zip_url "https://github.com/solsson/node-hello/archive/v1.0.2.zip"
ENV download_zip_sha256 "c6205e6adefa7c00163316750cc1486eb4fa4b8966e3718616fee5cbd5dddc15"
ENV download_strip_dirs 1

ADD download-and-start /usr/local/bin/

ENTRYPOINT ["download-and-start"]
