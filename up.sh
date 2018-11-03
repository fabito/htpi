#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app


readonly env=${1:-"settings.bash"}

if [ ! -f ${env} ]; then
    echo "${env} is missing. Create it first. Check instructions README.md"
    exit 1
fi

source ${env}

[ -d "$HTPC_HOME" ] || mkdir -p ${HTPC_HOME} && chown -R ${HTPC_USER_ID}:${HTPC_GROUP_ID} ${HTPC_HOME}
[ -d "$HTPC_CONFIG_HOME" ] || mkdir -p ${HTPC_CONFIG_HOME} && chown -R ${HTPC_USER_ID}:${HTPC_GROUP_ID} ${HTPC_CONFIG_HOME}
[ -d "$HTPC_MEDIA_HOME" ] || mkdir -p ${HTPC_MEDIA_HOME} && chown -R ${HTPC_USER_ID}:${HTPC_GROUP_ID} ${HTPC_MEDIA_HOME}
[ -d "$HTPC_DOWNLOAD_HOME" ] || mkdir -p ${HTPC_DOWNLOAD_HOME} && chown -R ${HTPC_USER_ID}:${HTPC_GROUP_ID} ${HTPC_DOWNLOAD_HOME}

help() {
  echo "Usage: "
  echo "${__base} {up, down}"
}

case "$2" in
  up)
    docker-compose ${HTPC_SERVICES} up -d
    ;;
  down)
    docker-compose ${HTPC_SERVICES} down
    ;;
  *)
    help
    ;;
esac
