#!/bin/bash -vx

set -e

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)" 

echo "New Game Install - cloning from ${ARES_GAME_CLONE_URL}"
ls -latr ${ARES_GAME_DIR}
(
    cd ${ARES_GAME_DIR}
    git clone --depth=4 --recurse-submodules \
    --single-branch -b ${ARES_GAME_BRANCH} ${ARES_GAME_GIT_URL} .
    cp -r install/game.distr game
    sed -i 's/\/home\/ares\/ares-webportal/\/ares\/ares-webportal/' game/config/website.yml
    chmod 0750 bin/*
    bundle install
    bundle exec rake configure_from_env
    bin/wipedb    
)

(
    cd /var/www/html && ln -s /ares/aresmush/game game
)
