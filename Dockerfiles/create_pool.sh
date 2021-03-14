[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build --no-cache -t tregtronics/pktpooldocker:1.0.0 -t tregtronics/pktpooldocker:latest -f Pool/Pool/Dockerfile .
