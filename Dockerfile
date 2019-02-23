FROM node:4
LABEL maintainer="nellcorp.com"

ENV coin mainnet
EXPOSE 3001 8333 8332 18333 18332
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y libzmq3-dev build-essential curl wget git

RUN npm install -g bitcore@4.1.0 --unsafe-perm
RUN wget https://raw.githubusercontent.com/figassis/docker-bitcore/master/setup.sh
RUN mv setup.sh /opt/setup && chmod +x /opt/setup

CMD ["sh","-c","/opt/setup $coin && bitcored"]