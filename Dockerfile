FROM ubuntu:xenial

MAINTAINER Fusonic "office@fusonic.net"

ARG DEBIAN_FRONTEND=noninteractive

ENV PATH='/root/.phpbrew/php/7.0/bin:/root/.phpbrew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
ENV PATH_WITHOUT_PHPBREW='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

ENV PHPBREW_BIN='/root/.phpbrew/bin'
ENV PHPBREW_PATH='/root/.phpbrew/php/7.1/bin'
ENV PHPBREW_ROOT='/root/.phpbrew'
ENV PHPBREW_HOME='/root/.phpbrew'
ENV PHPBREW_PHP='7.1'
ENV PHPBREW_LOOKUP_PREFIX=''
ENV PHPBREW_VERSION_REGEX='^([[:digit:]]+\.){2}[[:digit:]]+$'

ENV TRAVIS='1'

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y php7.0-cli php7.0-curl mysql-server git curl bzip2 \
                       libxslt1.1 libmcrypt4 libcurl3 libenchant1c2a libpng16-16 libgmp10 libc-client2007e libkrb5-3 \
                       libfbclient2 firebird2.5-common libldap-2.4-2 gcc make libxml2-dev libssl-dev libbz2-dev \
                       libmcrypt-dev libreadline6-dev libxslt1-dev libcurl4-openssl-dev libenchant-dev libpng16-dev \
                       libgmp3-dev libc-client2007e-dev libkrb5-dev firebird-dev libldap2-dev && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a && \
    curl -L https://getcomposer.org/composer.phar > /usr/bin/composer && chmod +x /usr/bin/composer && \
    curl -L https://github.com/phpbrew/phpbrew/raw/master/phpbrew>/usr/bin/phpbrew && chmod +x /usr/bin/phpbrew && \
    phpbrew init && \
    phpbrew install -j $(nproc) --name=5.5 5.5 +default+mysql+calendar+ftp+exif+soap+session+opcache+imap+xmlrpc+zlib+curl+gd+intl+openssl+xml_all+gettext+iconv && \
    phpbrew install -j $(nproc) --name=5.6 5.6 +default+mysql+calendar+ftp+exif+soap+session+opcache+imap+xmlrpc+zlib+curl+gd+intl+openssl+xml_all+gettext+iconv && \
    phpbrew install -j $(nproc) --name=7.0 7.0 +default+mysql+calendar+ftp+exif+soap+session+opcache+imap+xmlrpc+zlib+curl+gd+intl+openssl+xml_all+gettext+iconv && \
    phpbrew install -j $(nproc) --name=7.1 7.1 +default+mysql+calendar+ftp+exif+soap+session+opcache+imap+xmlrpc+zlib+curl+gd+intl+openssl+xml_all+gettext+iconv && \
    phpbrew clean -a 5.5 && \
    phpbrew clean -a 5.6 && \
    phpbrew clean -a 7.0 && \
    phpbrew clean -a 7.1 && \
    echo "mysqli.default_socket=/var/run/mysqld/mysqld.sock" >> ~/.phpbrew/php/5.5/etc/php.ini && \
    echo "mysqli.default_socket=/var/run/mysqld/mysqld.sock" >> ~/.phpbrew/php/5.6/etc/php.ini && \
    echo "mysqli.default_socket=/var/run/mysqld/mysqld.sock" >> ~/.phpbrew/php/7.0/etc/php.ini && \
    echo "mysqli.default_socket=/var/run/mysqld/mysqld.sock" >> ~/.phpbrew/php/7.1/etc/php.ini && \
    apt-get purge -y gcc make && \
    apt-get autoremove -y && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/share/man

ADD files /
