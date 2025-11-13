#!/usr/bin/env bash
set -euo pipefail

# Set verbosity
shopt -s nocasematch
case ${LOG_LEVEL} in
  error)
    __verbosity="--verbosity 1"
    ;;
  warn)
    __verbosity="--verbosity 2"
    ;;
  info)
    __verbosity="--verbosity 3"
    ;;
  debug)
    __verbosity="--verbosity 4"
    ;;
  trace)
    __verbosity="--verbosity 5"
    ;;
  *)
    echo "LOG_LEVEL ${LOG_LEVEL} not recognized"
    __verbosity=""
    ;;
esac

__public_ip="--nat=extip:$(wget -qO- https://ifconfig.me/ip)"

if [ -n "${GENESIS_URL}" ]; then
  if [ ! -d "/var/lib/neox/geth/" ]; then
    echo "Initializing geth datadir from genesis.json"

    # wget requires special recompile to support file://, instead just check
    if [[ "$GENESIS_URL" == file://* ]]; then
      LOCAL_PATH="${GENESIS_URL#file://}"
      cp "$LOCAL_PATH" /var/lib/neox/genesis.json
    else
      wget "$GENESIS_URL" -O /var/lib/neox/genesis.json
    fi

    geth init --datadir=/var/lib/neox --state.scheme="${INIT_STATE_SCHEME}" /var/lib/neox/genesis.json
  fi
fi

# Word splitting is desired for the command line parameters
# shellcheck disable=SC2086
exec "$@" ${__verbosity} ${__public_ip} ${EXTRAS}
