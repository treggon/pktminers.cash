[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build -t tregtronics/pktannh:1.0.0 -t tregtronics/pktannh01:latest -f Annhandler01/Dockerfile .
