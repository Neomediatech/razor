FROM alpine

LABEL maintainer="docker-dario@neomediatech.it"
LABEL it.neomediatech.razor.version="2.85-r7"
LABEL it.neomediatech.razor.build-time="2018-06-27 08:37:07"
LABEL it.neomediatech.razor.pkg-url="https://pkgs.alpinelinux.org/package/edge/main/x86/razor"

RUN apk update; apk add --no-cache razor python3 tzdata; rm -rf /usr/local/share/doc /usr/local/share/man; cp /usr/share/zoneinfo/Europe/Rome /etc/localtime
COPY razor/razorsocket.py /razorsocket.py
RUN chmod +x /razorsocket.py
EXPOSE 9192
CMD ["/razorsocket.py", "0.0.0.0", "9192"]
