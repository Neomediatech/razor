FROM neomediatech/ubuntu-base:20.04

ENV VERSION=2.85-4.2build5 \
    DEBIAN_FRONTEND=noninteractive \
    SERVICE=razor

ARG UPDATE=2021-08-16

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

COPY razor/razorsocket.py /razorsocket.py

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y netcat razor python3 && \
    rm -rf /var/lib/apt/lists* && \
    chmod +x /razorsocket.py

EXPOSE 9192

HEALTHCHECK --interval=30s --timeout=30s --start-period=20s --retries=20 CMD nc -w 7 -zv 0.0.0.0 9192

CMD ["/tini", "-e", "137", "-e", "143", "--", "/razorsocket.py", "0.0.0.0", "9192"]
