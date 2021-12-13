#!/bin/bash

set -e

INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/0.9.0/utils/install.sh"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/0.9.0/utils/uninstall.sh"
INSTALL_SCRIPT_PATH=/tmp/install_wasmedge.sh
UNINSTALL_SCRIPT_PATH=/tmp/uninstall_wasmedge.sh
INSTALL_PATH="$HOME/.wasmedge"
INSTALL_VERSION=0.9.0

mkdir -p "$INSTALL_PATH"

wget -O "$UNINSTALL_SCRIPT_PATH" "$UNINSTALL_SCRIPT_URL"
bash "$UNINSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -q

wget -O "$INSTALL_SCRIPT_PATH" "$INSTALL_SCRIPT_URL"
bash "$INSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -v "$INSTALL_VERSION"

rm -f $INSTALL_SCRIPT_PATH $UNINSTALL_SCRIPT_PATH
