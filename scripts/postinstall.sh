#!/bin/bash

set -e

RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
NC=$'\e[0m' # No Color
COMMAND="source $HOME/.wasmedge/env"

echo ''
echo ''
echo 'After version 0.8.2, we use install script from WasmeEdge to install WasmeEdge (and extensions).'
echo 'To use `wasmedge` command in current shell session, please follow instruction below:'
echo ''
echo $YELLOW'    ╭──────────────────────────────────╮'$NC
echo $YELLOW'    │ '$RED'PLEASE RUN THE FOLLOWING COMMAND'$YELLOW' │'$NC
echo $YELLOW'    │                                  │'$NC
echo $YELLOW'    │    source $HOME/.wasmedge/env    │'$NC
echo $YELLOW'    ╰──────────────────────────────────╯'$NC
echo ''
echo ''
echo ''
