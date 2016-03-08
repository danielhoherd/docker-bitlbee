FROM debian:jessie
MAINTAINER Nathan Handler <nathan.handler@gmail.com>

ENV BITLBEE_VERSION 3.4.1

RUN apt-get update && DEBIAN_FRONTEND=non_interactive apt-get install -y \
    autoconf \
    build-essential \
    git \
    libgcrypt20-dev \
    libglib2.0-dev \
    libgnutls28-dev \
    libjson-glib-dev \
    libtool \
    sudo \
    wget

RUN mkdir -p /src
RUN wget --quiet --directory-prefix=/src "http://get.bitlbee.org/src/bitlbee-${BITLBEE_VERSION}.tar.gz"
RUN tar xvzf "/src/bitlbee-${BITLBEE_VERSION}.tar.gz" --directory /src
RUN cd "/src/bitlbee-${BITLBEE_VERSION}" \
    && ./configure \
        --config=/var/lib/bitlbee \
        --prefix=/usr \
        --etcdir=/etc/bitlbee \
    && (make || make) \
    && (cd doc && make -C user-guide) \
    && make install \
    && make install-etc \
    && make install-dev
RUN apt-get autoremove -y
RUN apt-get clean

RUN git clone -q https://github.com/jgeboski/bitlbee-facebook.git /src/bitlbee-facebook
RUN cd /src/bitlbee-facebook \
    && ./autogen.sh \
    && make \
    && make install

RUN rm -rf /src* /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN useradd -d /var/lib/bitlbee --no-create-home --shell /usr/sbin/nologin bitlbee

ADD docker-entrypoint.sh /entrypoint.sh
ADD bitlbee.conf.default /bitlbee.conf.default
RUN mkdir -p /var/lib/bitlbee/ /var/run/bitlbee
RUN chmod 600 /var/lib/bitlbee

VOLUME /etc/bitlbee
VOLUME /var/lib/bitlbee

EXPOSE 6667
WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
