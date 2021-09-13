#!/usr/bin/env bash

set -xe

SUDO=
[ "$GITHUB_ACTIONS" == true ] && SUDO=sudo

rustwasmc build
cd pkg
$SUDO npm install ../..
cd -
mocha js
rustwasmc clean
