# Watchman

> Watch for a domain status and take some actions if it gets into trouble

## Setup

```sh
$ bundle install
```

## Usage

You may use the `watchman-expiry` CLI tool to retrieve expiry information for
domain names and SSL certificates, provided the guide below. For more options, please
run `./watchman-expiry -h`.

#### 1. Retrieve expiration date for a given domain:

```sh
$ ./watchman-expiry domain -u earaujoassis.com
```

or

```sh
$ ./watchman-expiry domain -u https://earaujoassis.com
```

#### 2. Retrieve expiration date for a SSL certificate, for a given domain:

```sh
$ ./watchman-expiry certificate -u https://earaujoassis.com
```

## Issues

Please take a look at [/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
