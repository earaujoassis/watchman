#!/bin/bash

set -ex

docker-compose build watchman
docker-compose up --no-deps -d watchman
