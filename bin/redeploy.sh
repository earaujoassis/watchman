#!/bin/bash

set -ex

docker-compose build watchman
docker-compose up --no-deps -d watchman
# docker rmi $(docker images -a --filter=dangling=true -q)
# docker rm $(docker ps --filter=status=exited --filter=status=created -q)
docker system prune -a -f
