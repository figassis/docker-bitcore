FROM node:4
LABEL maintainer="nellcorp.com"

ENV coin mainnet
EXPOSE 3001 8332 18332 8333 28332
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y libzmq3-dev build-essential curl wget git
RUN wget https://github.com/dashpay/dash/releases/download/v0.12.2.3/dashcore-0.12.2.3-linux64.tar.gz
RUN tar -xf dashcore-0.12.2.3-linux64.tar.gz && mv dashcore-0.12.2 /root/.dash && rm dashcore-0.12.2.3-linux64.tar.gz
RUN mkdir -p /root/.ssh && ssh-keyscan github.com > /root/.ssh/known_hosts
RUN git clone https://github.com/dashevo/bitcore-node-dash -b skip-dash-download
RUN mv bitcore-node-dash /root/bitcore-dash && cd /root/bitcore-dash && npm install && npm install insight-api-dash --S && npm install insight-ui-dash --S
RUN chmod +x /root/bitcore-dash/bin/bitcore-node-dash
RUN wget https://raw.githubusercontent.com/figassis/docker-bitcore/master/setup.sh
RUN mv setup.sh /opt/setup && chmod +x /opt/setup

CMD ["sh","-c","/opt/setup $coin && /root/bitcore-dash/bin/bitcore-node-dash start -c /root/.dashcore"]