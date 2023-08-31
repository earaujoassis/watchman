#!/usr/bin/env bash

set -e

docker-compose down
docker-compose build --build-arg COMMIT_HASH_ARG=$(git describe --always)
docker-compose up
