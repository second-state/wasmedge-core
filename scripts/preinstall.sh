#!/bin/bash

INSTALL_SCRIPT=/tmp/install_wasmedge.sh
INSTALL_PATH="$HOME/.wasmedge"
INSTALL_VERSION=0.8.2
SUDO=

wget -O "$INSTALL_SCRIPT" "https://raw.githubusercontent.com/WasmEdge/WasmEdge/766654ee0b655a06156278854d22be8042a2c6bd/utils/install.sh"
[ "$GITHUB_ACTIONS" == true ] && SUDO=sudo
$SUDO bash "$INSTALL_SCRIPT" -p "$INSTALL_PATH" --version "$INSTALL_VERSION"
