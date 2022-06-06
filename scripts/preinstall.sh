#!/bin/bash

set -e

INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/6c39907b806595f30492249ac2facc1f087c5d54/utils/install.sh"
INSTALL_SCRIPT_SHA1SUM="abcabe72879ec928b170209c97d1e35b7ef17e22"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/6c39907b806595f30492249ac2facc1f087c5d54/utils/uninstall.sh"
UNINSTALL_SCRIPT_SHA1SUM="2f9effcc2e2a171c351fd61f9e13db9211149b05"
INSTALL_SCRIPT_PATH=/tmp/install_wasmedge.sh
UNINSTALL_SCRIPT_PATH=/tmp/uninstall_wasmedge.sh
INSTALL_PATH="$HOME/.wasmedge"
INSTALL_VERSION=0.9.1

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
