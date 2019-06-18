FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV APP=''

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    xvfb x11vnc xterm \
    sudo \
    supervisor \
    ttf-wqy-microhei \
    wget \
    && add-apt-repository ppa:ubuntu-mozilla-security/ppa
    || apt-get update \
    && apt --fix-broken install -y \
    && rm -rf /var/lib/apt/lists/* 

RUN set -xe \
    && useradd -u 1000 -g 100 -G sudo --shell /bin/bash --no-create-home --home-dir /tmp user \
    && echo 'ALL ALL = (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY supervisord.conf /etc/
COPY entry.sh /

User user
WORKDIR /tmp

CMD ["/entry.sh"]
