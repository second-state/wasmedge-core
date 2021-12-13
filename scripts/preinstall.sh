#!/bin/bash

set -e

INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/0.9.0/utils/install.sh"
INSTALL_SCRIPT_SHA1SUM="604bed0f37f53e22c3706cba8327526fa0fc91cd"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/0.9.0/utils/uninstall.sh"
UNINSTALL_SCRIPT_SHA1SUM="5d634bf063f7130e0c92baf3912a5fa4bed19aef"
INSTALL_SCRIPT_PATH=/tmp/install_wasmedge.sh
UNINSTALL_SCRIPT_PATH=/tmp/uninstall_wasmedge.sh
INSTALL_PATH="$HOME/.wasmedge"
INSTALL_VERSION=0.9.0

mkdir -p "$INSTALL_PATH"

wget -O "$UNINSTALL_SCRIPT_PATH" "$UNINSTALL_SCRIPT_URL"
[ "$(sha1sum $UNINSTALL_SCRIPT_PATH | awk '{print $1}')" != "$UNINSTALL_SCRIPT_SHA1SUM" ] && \
    echo "Uninstall script checksum mismatch" && \
    exit 1
bash "$UNINSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -q

wget -O "$INSTALL_SCRIPT_PATH" "$INSTALL_SCRIPT_URL"
[ "$(sha1sum $INSTALL_SCRIPT_PATH | awk '{print $1}')" != "$INSTALL_SCRIPT_SHA1SUM" ] && \
    echo "Install script checksum mismatch" && \
    exit 1
bash "$INSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -v "$INSTALL_VERSION"

rm -f $INSTALL_SCRIPT_PATH $UNINSTALL_SCRIPT_PATH
