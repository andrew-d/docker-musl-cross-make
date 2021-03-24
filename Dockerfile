FROM debian:buster
MAINTAINER Andrew Dunham <andrew@du.nham.ca>

# Install build tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -yy && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
        automake            \
        bison               \
        build-essential     \
        curl                \
        file                \
        flex                \
        git                 \
        libtool             \
        pkg-config          \
        python              \
        texinfo             \
        vim                 \
        wget

RUN mkdir /build &&                                                 \
    cd /build &&                                                    \
    git clone https://github.com/richfelker/musl-cross-make.git &&  \
    cd musl-cross-make

ARG triple
ADD $triple.config.mak /build/musl-cross-make/config.mak

RUN cd /build/musl-cross-make && \
    make -j$(nproc)

RUN cd /build/musl-cross-make && \
    make install
