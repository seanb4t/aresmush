#!/bin/bash -vx

set -e 

mkdir -p /var/www/html /var/lib/redis /etc/redis /ares/ares-webportal

chown -R ${ARES_USERNAME} /var/www/html
chown -R ${ARES_USERNAME}:${ARES_USERNAME} /ares
[[ -d /etc/redis ]] && chgrp -R redis /etc/redis /var/lib/redis
[[ -d /etc/redis ]] && chmod g+wx /etc/redis /var/lib/redis
[[ -f /etc/redis/redis.conf ]] && chmod g+w /etc/redis/redis.conf /var/lib/redis/*

if [ ! -d /ares/game ]; then
  gosu ares /ares/ares-setup.sh
fi

cd ${ARES_GAME_DIR}
exec gosu ${ARES_USERNAME} /ares-entrypoint.sh

