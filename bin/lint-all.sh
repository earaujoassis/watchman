#!/usr/bin/env bash

set -ex

rake lint
yarn lint
flake8 ./agents
