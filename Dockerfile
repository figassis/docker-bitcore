FROM node:latest
ARG DEBIAN_FRONTEND=noninteractive

ENV coin dashmainnet
ENV DASHD_VERSION 0.13.1.0

# Update & install dependencies and do cleanup
RUN apt-get update && apt-get install -y software-properties-common inetutils-ping build-essential libzmq3-dev curl git wget python
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install dashd release
RUN curl --silent -L "https://github.com/dashpay/dash/releases/download/v$DASHD_VERSION/dashcore-$DASHD_VERSION-x86_64-linux-gnu.tar.gz" -o /tmp/dashcore.tar.gz
RUN mkdir /opt/dashd && tar xzf /tmp/dashcore.tar.gz -C /opt/dashd --strip 1 && rm /tmp/dashcore.tar.gz

# Install dashcore
# Because this is running under root, using --unsafe-perm helps ignore permissions issues
RUN npm install -g @dashevo/dashcore-node @dashevo/insight-api @dashevo/insight-ui --unsafe-perm
RUN wget https://raw.githubusercontent.com/figassis/docker-bitcore/master/setup.sh -O /opt/setup && chmod +x /opt/setup


EXPOSE 3001 8332 18332 8333 28332
CMD ["sh","-c","/opt/setup $coin && dashcore-node start"]
