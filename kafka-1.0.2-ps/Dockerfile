FROM solsson/kafka-jre@sha256:6ceb312a233f7903f554cf0d9391e9b5a927ebe9d807480506aee4d16d96bb71 as ps

FROM solsson/kafka:1.0.2@sha256:7fdb326994bcde133c777d888d06863b7c1a0e80f043582816715d76643ab789

COPY --from=ps /lib/x86_64-linux-gnu/libprocps.so.6* /lib/x86_64-linux-gnu/
COPY --from=ps /bin/ps /bin/ps
