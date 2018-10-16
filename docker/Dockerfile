FROM ubuntu:xenial

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update \
    && apt-get install -y curl ca-certificates apt-transport-https gnupg2 software-properties-common \
    && update-ca-certificates --fresh

ENV GOSU_VERSION 1.10
RUN set -ex; \
	\
	fetchDeps=' \
		wget \
	'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu nobody true; \
	\
	apt-get purge -y --auto-remove $fetchDeps

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN id; curl -vvvv -sS -o /tmp/yarn.key https://dl.yarnpkg.com/debian/pubkey.gpg ; cat /tmp/yarn.key && apt-key add /tmp/yarn.key ; rm /tmp/yarn.key
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && add-apt-repository -y ppa:chris-lea/redis-server \
    && apt-get update \
    && apt-get -y upgrade

RUN apt-get install -y \
    apt-transport-https \
    autoconf \
    automake \
    binutils \
    bison \
    build-essential \
    gawk \
    git \
    hugepages \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libtool  \
    libyaml-dev \
    nodejs \
    npm \
    pkg-config \
    python \
    ruby-bundler \
    ruby-all-dev \
    sqlite3  \
    && apt-get purge -y --auto-remove

ENV ARES_USERNAME=ares

RUN adduser --home /ares --shell /bin/bash --uid 1000 --disabled-password --gecos "Ares User" ${ARES_USERNAME} \
    && addgroup --gid 998 www \
    && addgroup --gid 999 redis \
    && usermod -a -G sudo,www,redis ${ARES_USERNAME}

VOLUME [ "/var/www/html", "/etc/redis", "/var/lib/redis" ]

COPY --chown=root:root docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=root:root ares-entrypoint.sh /ares-entrypoint.sh
RUN chmod 0755 /docker-entrypoint.sh \
    && mkdir -p /ares \
    && chown -R ares:ares /ares \
    && chmod 0770 /ares

ENV ARES_GAME_GIT_URL="https://github.com/AresMUSH/aresmush.git"
ENV ARES_GAME_BRANCH=master
ENV ARES_GAME_DIR=/ares/aresmush

USER ares
WORKDIR /ares
COPY --chown=ares:ares ruby-setup.sh /ares/ruby-setup.sh
RUN /ares/ruby-setup.sh

COPY --chown=ares:ares ares-setup.sh /ares/ares-setup.sh

USER root

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
