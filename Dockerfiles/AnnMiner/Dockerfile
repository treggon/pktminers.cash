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
CMD node ./blkmine.js --threads 35 --paymentAddr=pkt1qx0r8cz234gsle9ug8e8wre8d49udnzcjpaeuwy http://dalpool01.pktminers.cash
