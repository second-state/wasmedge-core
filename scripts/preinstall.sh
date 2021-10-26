#!/bin/bash

set -e

INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/uninstall.sh"
INSTALL_SCRIPT_PATH=/tmp/install_wasmedge.sh
UNINSTALL_SCRIPT_PATH=/tmp/uninstall_wasmedge.sh
INSTALL_PATH="$HOME/.wasmedge"
INSTALL_VERSION=0.9.0-rc.1
SUDO=
[ "$GITHUB_ACTIONS" == true ] && SUDO=sudo

mkdir -p "$INSTALL_PATH"

wget -O "$UNINSTALL_SCRIPT_PATH" "$UNINSTALL_SCRIPT_URL"
$SUDO bash "$UNINSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -q

wget -O "$INSTALL_SCRIPT_PATH" "$INSTALL_SCRIPT_URL"
$SUDO bash "$INSTALL_SCRIPT_PATH" -p "$INSTALL_PATH" -v "$INSTALL_VERSION"
