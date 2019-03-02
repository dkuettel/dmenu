#!/bin/zsh
set -eux -o pipefail

make clean
make
sudo make install
