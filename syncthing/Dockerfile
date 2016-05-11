FROM debian:jessie

ENV syncthing_version=v0.12.23
ENV syncthing_tgz_url=https://github.com/syncthing/syncthing/releases/download/$syncthing_version/syncthing-linux-amd64-$syncthing_version.tar.gz
ENV syncthing_sha1_url=https://github.com/syncthing/syncthing/releases/download/$syncthing_version/sha1sum.txt.asc

RUN depsRuntime=' \
	' \
  && depsBuild=' \
		curl ca-certificates \
    gnupg2 \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $depsRuntime \
	&& apt-get install -y --no-install-recommends $depsBuild \
	&& rm -r /var/lib/apt/lists/* \
	&& curl -SLs "$syncthing_tgz_url" -o syncthing-linux-amd64-$syncthing_version.tar.gz \
  && curl -SLs "$syncthing_sha1_url" -o syncthing-sha1sum.txt.asc \
	&& cat syncthing-sha1sum.txt.asc | grep linux-amd64 | sha1sum -c - \
  && gpg --keyserver pool.sks-keyservers.net --recv-key 49F5AEC0BCE524C7 D26E6ED000654A3E \
  && gpg --verify syncthing-sha1sum.txt.asc \
	&& mkdir -p opt/syncthing \
	&& tar -xvf syncthing-linux-amd64-$syncthing_version.tar.gz -C opt/syncthing --strip-components=1 \
	&& rm syncthing-* \
	&& apt-get purge -y --auto-remove $depsBuild

VOLUME /syncthing

EXPOSE 8384

ENTRYPOINT ["/opt/syncthing/syncthing", "-no-browser", "no-restart", "-home", "/syncthing"]
