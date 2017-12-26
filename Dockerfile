FROM node:4
LABEL maintainer="nellcorp.com"

EXPOSE 3001 8333 8332 18333 18332
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y libzmq3-dev build-essential curl

RUN npm install -g bitcore@4.1.0 --unsafe-perm

ENTRYPOINT [ "bitcored" ]
