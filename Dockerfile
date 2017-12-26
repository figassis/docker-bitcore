FROM node:4
MAINTAINER Assis Ngolo <figassis+dev@gmail.com>

EXPOSE 3001 8333 8332 18333 18332

RUN npm install -g bitcore

ENTRYPOINT [ "bitcored" ]
