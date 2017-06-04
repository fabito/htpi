#!/usr/bin/env bash

readonly env=${1:-"settings.bash"}

source ${env}

docker-compose -f transmission.yaml -f sickrage.yaml up -d
