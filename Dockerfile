FROM ubuntu:xenial

MAINTAINER Fusonic "office@fusonic.net"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y composer mysql-server git php7.0-cli php7.0-curl curl bzip2 libxslt1.1 libmcrypt4 libcurl3 \
                       libenchant1c2a libpng16-16 libgmp10 libc-client2007e libkrb5-3 libfbclient2 firebird2.5-common \
                       libldap-2.4-2 \
                       gcc make libxml2-dev libssl-dev libbz2-dev libmcrypt-dev libreadline6-dev libxslt1-dev \
                       libcurl4-openssl-dev libenchant-dev libpng16-dev libgmp3-dev libc-client2007-dev libkrb5-dev \
                       firebird-dev libldap2-dev && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a \
    curl -L https://github.com/phpbrew/phpbrew/raw/master/phpbrew>/usr/bin/phpbrew && \
    chmod +x /usr/bin/phpbrew && \
    phpbrew init && \
    phpbrew install -j $(nproc) --name=7.1 7.1 +default && \
    apt-get remove -y gcc make libxml2-dev libssl-dev libbz2-dev libmcrypt-dev libreadline6-dev libxslt1-dev && \
    apt-get autoremove -y && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/share/man
