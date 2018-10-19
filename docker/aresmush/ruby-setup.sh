#!/bin/bash -vx

set -e

git clone https://github.com/rbenv/rbenv.git ~/.rbenv 
( cd ~/.rbenv && src/configure && make -C src )

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
export PATH=$HOME/.rbenv/bin:$PATH

eval "$(rbenv init -)" 

mkdir -p "$(rbenv root)"/plugins 
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build 

echo 'eval "$(rbenv init -)"' | tee -a ~/.bashrc

rbenv install 2.5.1 
rbenv local 2.5.1
gem install bundler
gem install rake -v '12.3.0'
