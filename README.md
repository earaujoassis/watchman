# Watchman

> Watchman helps me keep track of QuatroLabs projects

Watchman is a Continuous Deployment server and a set of tools to keep track of projects,
deployments and servers. A previous project, Backdoor (a GitHub Webhook server), was merged
into it.

## Setup

```sh
$ bundle install
```

## Usage

You may use the `watchman-expiry` CLI tool to retrieve expiry information for
domain names and SSL certificates, provided the guide below. For more options, please
run `bin/watchman-expiry -h`.

#### 1. Retrieve expiration date for a given domain:

```sh
$ bin/watchman-expiry domain -u earaujoassis.com
```

or

```sh
$ bin/watchman-expiry domain -u https://earaujoassis.com
```

#### 2. Retrieve expiration date for a SSL certificate, for a given domain:

```sh
$ bin/watchman-expiry certificate -u https://earaujoassis.com
```

## Issues

Please take a look at [/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
