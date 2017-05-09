#!/bin/sh
modprobe ip6_tables
apt-get install -y autoconf flex bison gcc  build-essential libc6-dev libncurses5-dev libreadline-dev
mkdir dist
autoconf
# Configure just the protocols we need, and enable the client and IPv6
./configure  --with-protocols="bgp pipe static" --enable-ipv6=yes --enable-client=yes --enable-pthreads=yes --build=ppc64le --with-sysconfig=linux-v6
make

# Remove the dynmaic binaries and rerun make to create static binaries and store off the results
rm bird birdcl
make CC="gcc -static"
cp bird dist/bird6
cp birdcl dist

# Rerun the build but without IPv6 (or the client) and store off the result.
make clean
./configure  --with-protocols="bgp pipe static" --enable-client=no --enable-pthreads=yes --build=ppc64le --with-sysconfig=linux
make
rm bird 
make CC="gcc -static"
cp bird dist/bird

