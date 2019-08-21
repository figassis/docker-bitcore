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
        bitcoin_conf=$datadir/data/bitcoin.conf
        ;;
    ltcmainnet|ltctestnet)
        datadir=/root/.litecoin
        bitcore_conf=$datadir/litecore-node.json
        bitcoin_conf=$datadir/data/bitcoin.conf
        ;;
    dashmainnet|dashtestnet)
        datadir=/root/.dashcore
        bitcore_conf=$datadir/dashcore-node.json
        bitcoin_conf=$datadir/data/dash.conf
        ;; 
    *)
        exit 1
        ;;
esac

rm $datadir/data/*.pid

if [ -d "$datadir/data" ] && [ -f $bitcore_conf ] && [ -f $bitcoin_conf ]; then
  exit 0
fi

echo "We either did not find a $datadir directory, a $bitcore_conf or a $bitcoin_conf config files for $1"
echo "This is either the first launch or this container was running a different blockchain"
echo "We will remove everything under $datadir and attempt to backup $datadir/data to $datadir/data_old"


git clone https://github.com/figassis/bitcore

#Preserve old blockchain, if we had any. data_old should be removed manually upon verification that it is not needed.
mv $datadir/data $datadir/data_old

rm $datadir/*.json && mv bitcore/$1/* $datadir/ && rm -rf bitcore
exit #return error code from last command
