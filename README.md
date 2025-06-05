# Watchman

> Watchman helps to keep track of automating services; a tiny continuous deployment service

Watchman is a tiny continuous deployment service and a set of tools to
keep track of projects, deployments, and servers. It is intended to edge
computing contexts.

## The Watchman Service server

> A simple integration to GitHub's API to make deployments easier

The Watchman service is a really simple service that tracks GitHub
projects and make it easy to deploy them in a host machine. The
service server is written in Ruby on Rails. Agents are written in
Python and Robots in Go ([learn more](https://github.com/earaujoassis/watchman-bot)).

The service server, Agents, and Robots are decoupled because we
could have an Agent/Robot for every single service and a central
service server for deployments. The service server is concerned
about providing continuous deployment to a small set of projects,
in one server instance, used by a small team and with GitHub's
integration through access tokens.

## Agents & Robots

Agents are running processes inside each managed server. They
listen to the Service server to receive messages and instructions.
They have been migrated to their own project at
[earaujoassis/watchman-bot](https://github.com/earaujoassis/watchman-bot).

Robots are tiny agents intended to send messages and instructions
to the Service server.

## Old Watchman (deprecated)

A deprecated version of this project is available at the `deprecated`
branch. That version is not used nor maintained anymore.

## Issues

Please take a look at
[/issues](https://github.com/earaujoassis/watchman/issues)

## License

[MIT License](http://earaujoassis.mit-license.org/) &copy; Ewerton Assis
