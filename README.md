# Watchman

> Watchman helps keep track of GitHub projects; a tiny continuous deployment service

Watchman is a tiny continuous deployment service and a set of tools to keep track of projects,
deployments and servers. A previous project, Backdoor (a GitHub Webhook server), was merged
into it.

## Backdoor

> A simple webhook to GitHub's API to make deployments every time a release is created

Basically, every time a `ReleaseEvent` is sent to the GitHub webhook, a new action/message
is created in Backdoor's message broker and a given Agent is responsible to act upon that
action/message. The Backdoor's server is written in Ruby and Hanami (a really cool web
framework) and it uses RethinkDB to save application state. The Agents are written in
Python. The message broker is based on RabbitMQ.

Backdoor and Agents are decoupled because we could have an Agent for every single service
and a master Backdoor instance. It reminds the ideas used in [Kubernetes](http://kubernetes.io/).
Kubernetes goes (way) beyond the scope of Backdoor's intentions: it offers service discovery and load
balancing, horizontal scaling, batch execution etc. Backdoor is not really worried about this
because it's not offering services to a lot of users. It is only interested in providing
continuous deployment to a small set of projects, in one or a few server instances, used by a
small portion of people and with GitHub's integration (the webhook is the main requirement here).

Backdoor is also influenced by YouGov's velociraptor ([yougov/velociraptor](https://github.com/yougov/velociraptor)).
But again velociraptor goes (way) beyond what is offered here.

### Setup and running

You should set the environment variables according to the `.sample.env` and create a `.env`
file. Once you're done, run the following commands:

  ```sh
  $ bundle install
  $ bundle exec hanami server
  ```

The server is now working. You need to setup the Webhook under your repository's Settings
page now. For more information on how to proceed with that, please refer to the
[official documentation](https://developer.github.com/webhooks/).

### Caution

The current implementation doesn't worry about HTTPS and any other measure to secure the
communication between GitHub and your server. It's not a serious problem because no sensitive
data is transmitted if you're working with public repositories; but you should avoid this
if you plan to use it with a private repository. Ideally, Agents shouldn't be allowed to write
in your repository.

## Watchman Expiry

### Setup

```sh
$ bundle install
```

### Usage

You may use the `watchman-expiry` CLI tool to retrieve expiry information for
domain names and SSL certificates, provided the guide below. For more options, please
run `bin/watchman-expiry -h`.

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
