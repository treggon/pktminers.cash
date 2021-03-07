#!/bin/bash

while getopts t:a:b:p:h: flag
do
    case "${flag}" in
        t) SLEEP_IN_SECS=${OPTARG};;
        a) annthreads=${OPTARG};;
        b) blockthreads=${OPTARG};;
        p) paymentaddrfixed=${OPTARG};;
        h) pooladdress=${OPTARG};;
    esac
done

while (( 1 ))
do
        echo " About to nuke node"
        pkill -f ./target/release/packetcrypt

        if [ $annthreads ]
        then
            echo " Starting Announcement Miner"
            ./target/release/packetcrypt ann $pooladdress --paymentaddr $paymentaddrfixed --threads $annthreads&
        fi
        if [ $blockthreads ]
        then
            echo " Starting Packet Miner"
            ./target/release/packetcrypt blk $pooladdress --memorysizemb 90000 --paymentaddr $paymentaddrfixed --threads $blockthreads&
        fi

sleep ${SLEEP_IN_SECS}
done
