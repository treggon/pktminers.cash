[ ! -d "/blockchain/" ] && mkdir /blockchain
docker build -t treggon/pool:1.0.0 -t treggon/pool:latest -f Pool/Pool/Dockerfile .