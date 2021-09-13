#!/usr/bin/env bash
ARCH=$(node -e 'console.log(process.arch)')
npm run release
rm -rf wasmedge
mkdir wasmedge
cp build/Release/wasmedge.node wasmedge
strip wasmedge/wasmedge.node
tar zcvf wasmedge-linux-${ARCH}.tar.gz wasmedge
