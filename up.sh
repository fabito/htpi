#!/usr/bin/env bash

readonly env=${1:-"settings.bash"}

source ${env}

docker-compose up -f transmission.yaml -f sickrage.yaml -d
