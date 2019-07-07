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
$ bundle exec hanami db prepare
$ rake foreman
```

### Caution

The current implementation doesn't worry about HTTPS and any other measure to secure the communication
between GitHub and your server. It's not a serious problem because no sensitive data is transmitted
if you're working with public repositories; but you should avoid this if you plan to use it with
a private repository. Ideally, Agents shouldn't be allowed to write in your repository.

## Agents

Agents are running services inside each deployable server. They listen to the Watchman-Backdoor
server in order to receive instructions for deployment, for instance.

### Installing & Running

This is a Python `pip` package, so you're able to `pip install` it in your work environment. Basically,
it will make available an `agent` binary, which should be helpful to setup new projects and deploy
them in that running space (a server).

```sh
$ pip install --user https://github.com/earaujoassis/watchman/archive/v0.1.9.zip
```

If you need any help, please run `agent --help`.

### Developing agents

In order to create a sandbox (virtual environment) and install it for development or testing, you may
run the following commands:

```sh
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install .
$ agent --help
```

The `agent` binary will be available in the current shell session.

## Watchman Expiry (deprecated)

You may use the `watchman-expiry` CLI tool to retrieve expiry information for domain names and SSL
certificates, provided the guide below. First, you need to install dependencies through `bundle install`.
Then, you may run `bin/watchman-expiry domain -u earaujoassis.com` or
`bin/watchman-expiry domain -u https://earaujoassis.com` to retrieve expiration date for a given domain;
and `bin/watchman-expiry certificate -u https://earaujoassis.com` to retrieve expiration date for a
SSL certificate, for a given domain. For more options, please run `bin/watchman-expiry -h`.

## Issues

Please take a look at [/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
