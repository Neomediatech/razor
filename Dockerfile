FROM ghcr.io/neomediatech/ubuntu-base:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    SERVICE=razor

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

COPY razor/razorsocket.py /razorsocket.py

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y netcat-traditional razor python3 && \
    rm -rf /var/lib/apt/lists* && \
    chmod +x /razorsocket.py

EXPOSE 9192

HEALTHCHECK --interval=30s --timeout=30s --start-period=20s --retries=20 CMD nc -w 7 -zv 0.0.0.0 9192

CMD ["/tini", "-e", "137", "-e", "143", "--", "/razorsocket.py", "0.0.0.0", "9192"]
