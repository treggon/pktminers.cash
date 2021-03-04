#!/bin/bash

while getopts t:a:b:p:o: flag
do
    case "${flag}" in
        t) SLEEP_IN_SECS=${OPTARG};;
        a) annthreads=${OPTARG};;
        b) blockthreads=${OPTARG};;
        p) paymentaddrfixed=${OPTARG};;
        o) pooladdress=${OPTARG};;
        k) maxbw=${OPTARG};;
        m) maxanns=${OPTARG};;
    esac
done

while (( 1 ))
do
        echo " About to nuke node"
        pkill -f ./target/release/packetcrypt

        if [ $annthreads ]
        then
            echo " Starting Announcement Miner"
            node ./annmine.js  --maxKbps $maxbw --threads $annthreads --paymentAddr=$paymentaddrfixed $pooladdress &
        fi
        if [ $blockthreads ]
        then
            echo " Starting Packet Miner"
            node ./blkmine.js --maxKbps $maxbw --threads $annthreads --maxAnns $maxanns --paymentAddr=pRoX4rXvd9JKL8ic4P1X3eDXZkFNk9ai6G $pooladdress &
        fi
sleep ${SLEEP_IN_SECS}
done
