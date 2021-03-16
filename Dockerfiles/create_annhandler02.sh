[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build --no-cache -t tregtronics/pktannh02:1.0.0 -t tregtronics/pktannh02:latest -f Annhandler02/Dockerfile .
