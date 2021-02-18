# Start with ubuntu
FROM ubuntu:latest
# update and install curl, golang-go, git, vim
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git
RUN DEBIAN_FRONTEND="noninteractive" apt install -y vim
RUN DEBIAN_FRONTEND="noninteractive" apt install -y systemctl

# Clone the stuff we will need
RUN DEBIAN_FRONTEND="noninteractive" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -y | sh
RUN DEBIAN_FRONTEND="noninteractive" apt install -y paymaker

RUN git clone https://github.com/treggon/pktminers.cash
RUN git clone https://github.com/cjdelisle/packetcrypt_rs

# Install PKTD
WORKDIR /packetcrypt_rs
RUN DEBIAN_FRONTEND="noninteractive" ~/.cargo/bin/cargo build --release --features jemalloc
