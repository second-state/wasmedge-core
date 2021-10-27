#!/usr/bin/env bash

set -xe

rustwasmc build
cd pkg
npm install --unsafe-perm ../..
cd -
mocha js
rustwasmc clean
