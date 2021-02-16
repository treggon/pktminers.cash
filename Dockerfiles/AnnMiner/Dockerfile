FROM ubuntu:latest
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y curl
RUN DEBIAN_FRONTEND="noninteractive" apt install -y pkg-config libsodium-dev autoconf-archive git libssl-dev build-essential
RUN git clone https://github.com/cjdelisle/PacketCrypt/tree/1b76e1a94e1ea1fe53d4ad784cd76010ae607a1c
RUN cd PacketCrypt
RUN ./autogen.sh
RUN ./configure
RUN make
RUN DEBIAN_FRONTEND="noninteractive" npm install -y
ENTRYPOINT ["/bin/bash"]
