FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl
RUN add-apt-repository universe
RUN apt install pkg-config libsodium-dev autoconf-archive git libssl-dev build-essential
RUN git clone https://github.com/cjdelisle/PacketCrypt
RUN cd PacketCrypt
RUN ./autogen.sh
RUN ./configure
RUN make
RUN npm install
ENTRYPOINT ["/bin/bash"]
