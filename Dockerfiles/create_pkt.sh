[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build --no-cache -t tregtronics/pkt:3.0.0 -t tregtronics/pkt:latest -f Packet/Pool/Dockerfile .
