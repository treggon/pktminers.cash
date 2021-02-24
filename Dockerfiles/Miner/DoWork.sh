#!/bin/bash
SLEEP_IN_SECS=97
while (( 1 ))
do
        echo " About to nuke node"
        pkill -f ./target/release/packetcrypt
        echo " Starting Announcement Miner"
        nice ./target/release/packetcrypt ann http://dalpool01.pktminers.cash/ --paymentaddr pkt1qrfndt6fklnkslkqzwv3gmdmhj9xtatp4gr2479 --threads 35&
        echo " Starting Packet Miner"
        nice ./target/release/packetcrypt blk http://dalpool01.pktminers.cash/ --memorysizemb 90000 --paymentaddr pkt1qrfndt6fklnkslkqzwv3gmdmhj9xtatp4gr2479 --threads 35&
sleep ${SLEEP_IN_SECS}
done
