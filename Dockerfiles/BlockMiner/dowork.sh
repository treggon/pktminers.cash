SLEEP_IN_SECS=67
while (( 1 ))
do
        echo " About to nuke node"
        ps -aef | grep node | awk '{print $2}' | while read a
        do
        kill ${a}
        done
        nice -n 15 node ./PacketCrypt/blkmine.js --maxKbps 10000000 --threads 2 --maxAnns 4000000 --paymentAddr=pRoX4rXvd9JKL8ic4P1X3eDXZkFNk9ai6G http://pool.gridfinity.com/master &
sleep ${SLEEP_IN_SECS}
done
