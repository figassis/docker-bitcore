FROM node:4
LABEL maintainer="nellcorp.com"

EXPOSE 3001 9332 9333 19332 19335
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y libzmq3-dev build-essential curl

RUN npm install -g litecore --unsafe-perm

ENTRYPOINT [ "litecored" ]
