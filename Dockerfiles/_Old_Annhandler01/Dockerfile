# Start with ubuntu
FROM ubuntu:latest
# update and install curl, golang-go, git, vim
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl
RUN DEBIAN_FRONTEND="noninteractive" apt install -y golang-go
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git
RUN DEBIAN_FRONTEND="noninteractive" apt install -y vim
RUN DEBIAN_FRONTEND="noninteractive" apt install -y systemctl

# Clone the stuff we will need
RUN git clone https://github.com/treggon/pktminers.cash
RUN git clone https://github.com/pkt-cash/pktd
RUN git clone --branch develop https://github.com/cjdelisle/PacketCrypt
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

#Add the nginx configurations
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Annhandler01/reverse-proxy.conf /etc/nginx/sites-available
RUN DEBIAN_FRONTEND="noninteractive" ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
RUN DEBIAN_FRONTEND="noninteractive" rm default

#Setup Rust, Setup Cargo
WORKDIR /packetcrypt_rs
RUN curl https://sh.rustup.rs -sSf --no-modify-path none | sh -s
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y cargo
RUN cargo build --release --features jemalloc

# Move in the latest config files
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Pool/pool.toml /packetcrypt_rs
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/Pool/StartPool.sh /pktd

#Sets Reverse Proxy Sub-domain USAGE - ./set_annproxy.sh ann01
ADD https://raw.githubusercontent.com/treggon/pktminers.cash/main/Dockerfiles/set_annproxy.sh /packetcrypt_rs

RUN DEBIAN_FRONTEND="noninteractive" nginx -t

EXPOSE 8201/tcp
VOLUME ["/blockchain"]
RUN systemctl enable nginx
RUN systemctl start nginx
