# Watchman

> Watchman helps keep track of GitHub projects; a tiny continuous deployment service

Watchman is a tiny continuous deployment service and a set of tools to keep track of projects,
deployments and servers. A previous project, Backdoor (a GitHub integration server), was merged
into it.

## Backdoor

> A simple integration to GitHub's API to make deployments easier

Backdoor is a really simple service that tracks GitHub projects and make it easy to deploy them
in Hanami's host machine. The Backdoor's server is written in Ruby and Hanami (a really cool web
framework) and it uses PostgreSQL to save application state. The Agents are written in Python.

Backdoor and Agents are decoupled because we could have an Agent for every single service and a
master Backdoor instance. Backdoor is concerned about providing continuous deployment to a small
set of projects, in one server instance, used by a small portion of people and with GitHub's
integration.

Backdoor is also influenced by YouGov's velociraptor
([yougov/velociraptor](https://github.com/yougov/velociraptor)). However, velociraptor goes (way)
beyond what is offered here.

### Setup and running

You should set the environment variables according to the `.env.development`. Once you're done,
run the following commands:

```sh
$ bundle install
$ rake foreman
```

### Caution

The current implementation doesn't worry about HTTPS and any other measure to secure the communication
between GitHub and your server. It's not a serious problem because no sensitive data is transmitted
if you're working with public repositories; but you should avoid this if you plan to use it with a private
repository. Ideally, Agents shouldn't be allowed to write in your repository.

## Watchman Expiry

### Setup

```sh
$ bundle install
```

### Usage

You may use the `watchman-expiry` CLI tool to retrieve expiry information for domain names and SSL certificates,
provided the guide below. For more options, please run `bin/watchman-expiry -h`.

##### 1. Retrieve expiration date for a given domain:

```sh
$ bin/watchman-expiry domain -u earaujoassis.com
```

or

```sh
$ bin/watchman-expiry domain -u https://earaujoassis.com
```

##### 2. Retrieve expiration date for a SSL certificate, for a given domain:

```sh
$ bin/watchman-expiry certificate -u https://earaujoassis.com
```

## Issues

Please take a look at [/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
