#!/bin/zsh
set -eux -o pipefail

# add upstream and setup master branch from there for occasional updates
git remote add upstream git://git.suckless.org/dmenu || true
git fetch upstream
git branch master upstream/master || true
