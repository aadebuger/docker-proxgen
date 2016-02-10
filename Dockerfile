FROM ubuntu

RUN apt-get update
RUN apt-get install -yq unzip
RUN apt-get install -yq git
RUN apt-get install -yq curl
RUN apt-get install -yq cmake build-essential
RUN apt-get install -yq \
    flex \
    bison \
    libkrb5-dev \
    libsasl2-dev \
    libnuma-dev \
    pkg-config \
    libssl-dev \
    libcap-dev \
    gperf \
    autoconf-archive \
    libevent-dev \
    libgoogle-glog-dev \
    wget
WORKDIR /home
RUN git clone https://github.com/facebook/proxygen.git
add deps.sh /home/proxygen/proxygen
WORKDIR /home/proxygen/proxygen
run ls /home/proxygen/proxygen/lib/test/
#run sed -i 's/https:\/\/googlemock.googlecode.com\/files/http:\/\/7xqqx7.com1.z0.glb.clouddn.com/g' /home/proxygen/proxygen/lib/test/Makefile.in
RUN ./deps.sh || echo "hello deps" 
RUN ./reinstall.sh
WORKDIR /home/proxygen/proxygen/httpserver/samples/echo
RUN g++ -I /home/proxygen -std=c++11 -o my_echo EchoServer.cpp EchoHandler.cpp -lproxygenhttpserver -lfolly -lglog -lgflags -pthread
