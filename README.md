# Watchman [![Build Status](https://www.travis-ci.com/earaujoassis/watchman.svg?branch=master)](https://www.travis-ci.com/earaujoassis/watchman) [![codecov](https://codecov.io/gh/earaujoassis/watchman/branch/master/graph/badge.svg)](https://codecov.io/gh/earaujoassis/watchman)

> Watchman helps to keep track of automating services; a tiny continuous deployment service

Watchman is a tiny continuous deployment service and a set of tools to keep track of projects,
deployments, and servers. A previous project, Backdoor (a GitHub integration server), was merged
into it. It is intended to edge computing contexts.

## Backdoor

> A simple integration to GitHub's API to make deployments easier

Backdoor is a really simple service that tracks GitHub projects and make it easy to deploy them
in a host machine. The Backdoor's server is written in Ruby and Hanami and it uses PostgreSQL to
save application state. [Agents are written in Python and Robots in Go](https://github.com/earaujoassis/watchman-bot).

Backdoor, Agents, and Robots are decoupled because we could have an Agent/Robot for every single
service and a central Backdoor deployment. Backdoor is concerned about providing continuous deployment
to a small set of projects, in one server instance, used by a small team and with GitHub's
integration through access tokens.

### Setup and running

You should set the environment variables according to the `.env.development`. Once you're done,
run the following commands:

```sh
$ bundle install
$ bundle exec hanami db prepare
$ rake foreman:all
```

## Agents & Robots

Agents are running processes inside each managed server. They listen to the Watchman-Backdoor
server in order to receive messages and instructions. They have been migrated to
their own project at [earaujoassis/watchman-bot](https://github.com/earaujoassis/watchman-bot).

Robots are tiny agents intended to send messages and instructions to the Watchman-Backdoor server.

## Watchman Expiry (deprecated)

You may use the `watchman-expiry` CLI tool to retrieve expiry information for domain names and SSL
certificates, provided the guide below. First, you need to install dependencies through `bundle install`.
Then, you may run `scripts/watchman-expiry domain -u earaujoassis.com` or
`scripts/watchman-expiry domain -u https://earaujoassis.com` to retrieve expiration date for a given domain;
and `scripts/watchman-expiry certificate -u https://earaujoassis.com` to retrieve expiration date for a
SSL certificate, for a given domain. For more options, please run `scripts/watchman-expiry -h`.

## Issues

Please take a look at [/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
