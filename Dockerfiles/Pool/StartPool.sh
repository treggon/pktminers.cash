#!/bin/bash

while getopts p:m:k:b:a: flag
do
    case "${flag}" in
        p) pktd_address=${OPTARG};;
        m) masternodestart=1;;
        k) paymakerstart=1;;
        b) blockhandlerstart=1;;
        a) annhandlerstart=1;;
    esac
done

echo " About to nuke node"
pkill -f node
pkill -f packetcrypt

if [ $pktd_address ]
then
    echo " Starting PKTD"
    ./bin/pktd --rpcuser=rpcuser --rpcpass=0dc8eff1-d3ba-4b12-97b6-3e145944533e-2158e8a8-ee9f-4a65-89d4-633cc1e7bb47 --miningaddr $pktd_address
fi

cd ../PacketCrypt
if [ $masternodestart ]
then
    echo " Starting Master Node"
    node ./pool.js --master &
fi

if [ $paymakerstart ]
then
    echo " Starting Master Node"
    node ./pool.js --payMaker &
fi

if [ $blockhandlerstart ]
then
    echo " Starting Master Node"
    node ./pool.js --blk0 &
fi

if [ $annhandlerstart ]
then
    echo " Starting Master Node"
    node ./pool.js --ann0 &
fi
