# Start with ubuntu
FROM ubuntu:latest
# update and install curl, golang-go, git, vim
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl

#RUN DEBIAN_FRONTEND="noninteractive" apt-get add-apt-repository ppa:longsleep/golang-backports
RUN DEBIAN_FRONTEND="noninteractive" apt install -y golang-go

RUN DEBIAN_FRONTEND="noninteractive" apt install -y git
RUN DEBIAN_FRONTEND="noninteractive" apt install -y vim
RUN DEBIAN_FRONTEND="noninteractive" apt install -y systemctl

# Install ping/IpTools net tools
RUN DEBIAN_FRONTEND="noninteractive" apt install -y inetutils-ping
RUN DEBIAN_FRONTEND="noninteractive" apt install -y net-tools

# Clone the stuff we will need
RUN git clone https://github.com/treggon/pktminers.cash
RUN git clone --branch develop https://github.com/pkt-cash/pktd
RUN git clone https://github.com/cjdelisle/PacketCrypt
RUN git clone --branch develop https://github.com/cjdelisle/packetcrypt_rs

# Install PKTD
WORKDIR /pktd
RUN ./do

WORKDIR ~
RUN DEBIAN_FRONTEND="noninteractive" apt install -y npm
RUN DEBIAN_FRONTEND="noninteractive" npm cache clean -f
RUN DEBIAN_FRONTEND="noninteractive" npm install -g n
RUN DEBIAN_FRONTEND="noninteractive" n stable

# Install PacketCrypt
WORKDIR /PacketCrypt
RUN DEBIAN_FRONTEND="noninteractive" npm install

# Setup to accept external machines for payouts
# NGINX proxy server
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt install -y nginx
RUN DEBIAN_FRONTEND="noninteractive" unlink /etc/nginx/sites-enabled/default
WORKDIR /etc/nginx/sites-available


RUN DEBIAN_FRONTEND="noninteractive" ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
RUN DEBIAN_FRONTEND="noninteractive" rm default

#Setup Rust, Setup Cargo
WORKDIR /pktd
RUN curl https://sh.rustup.rs -sSf --no-modify-path none | sh -s
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y cargo

#Setup Rust, Setup Cargo
WORKDIR /packetcrypt_rs
RUN curl https://sh.rustup.rs -sSf --no-modify-path none | sh -s
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y cargo
RUN cargo build --release --features jemalloc

#Add the nginx configurations
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Packet/Pool/reverse-proxy.conf /etc/nginx/sites-available
# Move in the latest config files
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Packet/pool.js /PacketCrypt
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Packet/pool.toml /packetcrypt_rs
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Packet/StartPool.sh /pktd

RUN DEBIAN_FRONTEND="noninteractive" nginx -t
RUN DEBIAN_FRONTEND="noninteractive" systemctl start nginx
RUN DEBIAN_FRONTEND="noninteractive" systemctl enable nginx

#Sets Reverse Proxy Sub-domain USAGE - ./set_annproxy.sh ann01
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/set_annproxy.sh /packetcrypt_rs

#NGINX
EXPOSE 80/tcp

#Paymaker
EXPOSE 8081/tcp

#Master
EXPOSE 8080/tcp

#Block Handler
EXPOSE 8100/tcp

#AnnHanler
#EXPOSE 8201/tcp

#RPC
EXPOSE 64765/tcp

VOLUME ["/blockchain"]
CMD ./bin/pktd --rpcuser=rpcuser --rpcpass=0dc8eff1-d3ba-4b12-97b6-3e145944533e-2158e8a8-ee9f-4a65-89d4-633cc1e7bb47 --miningaddr pkt1qn8xat2f8gcv4w2mcqnzxrdq3r5vkp7fswgr2x9 &
