FROM alpine:3.9

LABEL maintainer="docker-dario@neomediatech.it"
LABEL it.neomediatech.razor.version="2.85-r7"
LABEL it.neomediatech.razor.build-time="2018-12-20 07:58:06"
LABEL it.neomediatech.razor.pkg-url="https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/razor"

RUN apk update && apk add --no-cache razor python3 tzdata tini bash && \
    rm -rf /usr/local/share/doc /usr/local/share/man && \ 
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime
COPY razor/razorsocket.py /razorsocket.py
RUN chmod +x /razorsocket.py
EXPOSE 9192
HEALTHCHECK --interval=30s --timeout=30s --start-period=20s --retries=20 CMD nc -w 7 -zv 0.0.0.0 9192
CMD ["tini", "-e", "137", "-e", "143", "--", "/razorsocket.py", "0.0.0.0", "9192"]
