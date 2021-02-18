FROM ubuntu:latest
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl

RUN DEBIAN_FRONTEND="noninteractive" apt install -y golang-go
RUN DEBIAN_FRONTEND="noninteractive" apt install -y git

RUN git clone https://github.com/treggon/pktminers.cash
RUN git clone https://github.com/pkt-cash/pktd
WORKDIR /pktd
RUN ./do
WORKDIR ~
RUN DEBIAN_FRONTEND="noninteractive" apt install -y npm
RUN DEBIAN_FRONTEND="noninteractive" npm cache clean -f
RUN DEBIAN_FRONTEND="noninteractive" npm install -g n
RUN DEBIAN_FRONTEND="noninteractive" n stable
RUN sh autogen.sh
