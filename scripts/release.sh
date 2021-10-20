#!/usr/bin/env bash

set -e

ARCH=$(node -e 'console.log(process.arch)')
MODULE_NAME=wasmedge
npm run release
rm -rf $MODULE_NAME
mkdir $MODULE_NAME
cp build/Release/$MODULE_NAME.node $MODULE_NAME
strip $MODULE_NAME/$MODULE_NAME.node
tar zcvf $MODULE_NAME-linux-${ARCH}.tar.gz $MODULE_NAME
