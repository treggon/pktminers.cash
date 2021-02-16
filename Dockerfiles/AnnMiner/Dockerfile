FROM ubuntu:latest
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl
RUN DEBIAN_FRONTEND="noninteractive" apt install -y pkg-config npm libsodium-dev autoconf-archive git libssl-dev build-essential
RUN git clone https://github.com/treggon/pktminers.cash
WORKDIR /pktminers.cash/PacketCrypt
RUN sh autogen.sh
RUN sh configure
RUN make
RUN npm install

ENTRYPOINT ["/bin/bash"]
