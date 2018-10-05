FROM gcr.io/cloud-builders/kubectl@sha256:a0f6b3969761c2d5a62ecf8ba3cba6de035ff5ff2743f300e678d1eb6b23f53a \
  as kubectl

RUN whereis kubectl

FROM cfssl/cfssl@sha256:f5ca56a93dbb5506d79833cf4869dcca0df4e2d200d5eff9856f35041505d2a7 \
  as cfssl

RUN whereis cfssl

FROM debian:stretch-slim@sha256:40b4072ce18fabe32f357f7c9ec1d256d839b1b95bcdc1f9c910823c6c2932e9

COPY --from=kubectl /builder/google-cloud-sdk/bin/kubectl /usr/local/bin/kubectl
RUN kubectl version --client

COPY --from=cfssl /go/bin/cfssl /usr/local/bin/cfssl
RUN cfssl version
