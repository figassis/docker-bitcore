#!/bin/bash

if [ -z "$1" ]; then
	exit 1
fi;

datadir=/root/.bitcore
bitcore_conf=$datadir/bitcore-node.json
bitcoin_conf=$datadir/data/bitcoin.conf

case $1 in
    mainnet|testnet)
        datadir=/root/.bitcore
        bitcore_conf=$datadir/bitcore-node.json
        ;;
    ltcmainnet|ltctestnet)
        datadir=/root/.litecoin
        bitcore_conf=$datadir/litecore-node.json
        ;;
    dashmainnet|dashtestnet)
        datadir=/root/.bitcore
        bitcore_conf=$datadir/bitcore-node-dash.json
        ;; 
    *)
        exit 1
        ;;
esac

if [ -d "$datadir/data" ] && [ -f bitcore_conf ] && [ -f bitcoin_conf ]; then
  exit 0
fi

git clone https://github.com/figassis/bitcore
rm -rf datadir && mv bitcore/$1 $datadir && rm -rf bitcore
exit #return error code from last command