#!/bin/bash
SLEEP_IN_SECS=97
while (( 1 ))
do
        echo " About to nuke node"
        pkill -f ./target/release/packetcrypt
        echo " Starting Announcement Miner"
        nice -n 5 ./target/release/packetcrypt ann http://dalpool01.pktminers.cash/ --paymentaddr pkt1qrfndt6fklnkslkqzwv3gmdmhj9xtatp4gr2479 --threads 32&
        echo " Starting Packet Miner"
        nice -n 5 ./target/release/packetcrypt blk http://dalpool01.pktminers.cash/ --paymentaddr pkt1qrfndt6fklnkslkqzwv3gmdmhj9xtatp4gr2479 --threads 32&
sleep ${SLEEP_IN_SECS}
done
