[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build -t tregtronics/pktannh:1.0.0 -t tregtronics/pktannh02:latest -f Annhandler02/Dockerfile .
