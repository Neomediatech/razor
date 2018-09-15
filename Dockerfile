FROM alpine

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update; apk add --no-cache razor python3 tzdata; rm -rf /usr/local/share/doc /usr/local/share/man; cp /usr/share/zoneinfo/Europe/Rome /etc/localtime
COPY razor/razorsocket.py /razorsocket.py
RUN chmod +x /razorsocket.py
EXPOSE 9192
CMD ["/razorsocket.py", "0.0.0.0", "9192"]
