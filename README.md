# razor-docker-alpine
Docker image of Vipul's Razor.

This image contains razor software taken from Alpine repository and "daemonized" with a python3 script.

This image contains parts of @cgt rspamd-plugins work (MIT license).

## Usage
 - docker run -d -p 0.0.0.0:9192:9192 --name razor neomediatech/razor:latest
 - point your mailserver to this container on port 9192
 
 
