[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build --no-cache -t tregtronics/ann:1.0.0 -t tregtronics/ann:latest -f Packet/Pool/Dockerfile .
