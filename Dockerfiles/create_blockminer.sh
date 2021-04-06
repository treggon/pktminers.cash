[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build --no-cache -t tregtronics/blkminer:1.0.0 -t tregtronics/blkminer:latest -f Packet/Pool/Dockerfile .
