#!/bin/bash -vx

echo "*** Environment"
env

echo "*** /ares/aresmush contents"
find /ares/aresmush --print

echo "*** /ares/ares-webportal contents"
find /ares/ares-webportal --print

set -e 

mkdir -p /var/www/html /var/lib/redis /etc/redis /ares/ares-webportal

chown -R ${ARES_USERNAME} /var/www/html
chown -R ${ARES_USERNAME}:${ARES_USERNAME} /ares
[[ -d /etc/redis ]] && chgrp -R redis /etc/redis /var/lib/redis
[[ -d /etc/redis ]] && chmod g+wx /etc/redis /var/lib/redis
[[ -f /etc/redis/redis.conf ]] && chmod g+w /etc/redis/redis.conf /var/lib/redis/*

if [ ! -d ${ARES_GAME_DIR}/game ]; then
  gosu ares /ares/ares-setup.sh
fi

if [ ! -d ${ARES_WEBPORTAL_DIR} ]; then
  gosu ares git clone --depth=1 -b ${ARES_WEBPORTAL_BRANCH} ${ARES_WEBPORTAL_GIT_URL} ${ARES_WEBPORTAL_DIR}
fi

cd ${ARES_GAME_DIR}
exec gosu ${ARES_USERNAME} /ares-entrypoint.sh

