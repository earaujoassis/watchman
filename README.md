# Watchman

> Watchman helps me keep track of QuatroLabs projects

Watchman is a Continuous Deployment server and a set of tools to keep track of projects,
deployments and servers. A previous project, Backdoor (a GitHub Webhook server), was merged
into it.

## Backdoor

> A simple webhook to GitHub's API to make deployments every time a release is created

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
if you plan to use it with a private repository.

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
