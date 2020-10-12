# +++ Being abandoned in favor of [razorfy-docker](https://github.com/Neomediatech/razorfy-docker) +++

# Docker image of Vipul's Razor
This image contains razor software taken from Ubuntu repository and "daemonized" with a python3 script.  
This image contains parts of @cgt rspamd-plugins work (MIT license).

## Usage
 - **`docker run -d -p 127.0.0.1:9192:9192 --name razor neomediatech/razor-ubuntu:latest`**  
   (or `docker run -d -p 0.0.0.0:9192:9192 --name razor neomediatech/razor-ubuntu:latest` if you need to access it from outside host)
 - point your mailserver to this container on port 9192
 
 
