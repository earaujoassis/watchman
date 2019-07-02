#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

from agents.cli import AgentCLI


name = "agents"
version = "0.1.2"


def main():
    code = AgentCLI.apply(sys.argv)
    sys.exit(code)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        sys.exit(0)
