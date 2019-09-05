FROM ubuntu:latest
MAINTAINER Kalvin Harris <harriskalvin585@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/zzz-no-recommends \
 && apt-get update && apt-get install -y \
    git ca-certificates build-essential autoconf automake libtool \
    libxml2-dev libogg-dev libvorbis-dev libshout3-dev \
    libmp3lame-dev libflac-dev libfaad-dev libmp4v2-dev \
    libpython2.7-dev libperl-dev \
    libxml2 libogg0 libvorbis0a libvorbisenc2 libvorbisfile3 libshout3 \
    libmp3lame0 libflac8 libfaad2 libmp4v2-2 \
    python2.7 perl \
 && git clone https://github.com/Moonbase59/ices0.git \
 && cd ices0 && aclocal && autoreconf -f -i -v \
 && ./configure && make && make install \
 && for file in $(find /usr/local/etc/ -name \*\.dist); do mv $file ${file%".dist"}; done \
 && apt-get remove --purge --auto-remove -y \
    git ca-certificates build-essential autoconf automake libtool \
    libxml2-dev libogg-dev libvorbis-dev libshout3-dev \
    libmp3lame-dev libflac-dev libfaad-dev libmp4v2-dev \
    libpython2.7-dev libperl-dev \
 && rm -rf /tmp/* /var/lib/apt/lists/* /etc/apt/apt.conf.d/zzz-no-recommends \
 && apt-get clean -y

ENTRYPOINT ["/usr/local/bin/ices"]
