[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build -t tregtronics/pktannh:1.0.0 -t tregtronics/pktannh:latest -f Annhandler/Dockerfile .
