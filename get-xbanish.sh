#!/bin/bash

git clone https://github.com/jcs/xbanish.git
sudo apt-get install libxfixes-dev libxt-dev libxi-dev
pushd xbanish
make && sudo make install
popd
rm -rf xbanish
