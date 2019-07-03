# -*- coding: utf-8 -*-

import os
import sys
import subprocess
import shlex
import socket
import fcntl
import struct


DEPLOYMENT_TYPE_STATIC     = 0
DEPLOYMENT_TYPE_CONTAINERS = 1
DEPLOYMENT_TYPE_COMPOSE    = 2


class ConsoleColors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


def print_error(message):
    sys.stderr.write(ConsoleColors.FAIL + message + ConsoleColors.END + '\n')


def print_success(message):
    sys.stdout.write(ConsoleColors.GREEN + message + ConsoleColors.END + '\n')


def print_step(message):
    sys.stdout.write(ConsoleColors.BOLD + message + ConsoleColors.END + '\n')


def call(c, shell=True):
    return subprocess.call(c, shell=shell)


def run(c):
    process = subprocess.Popen(shlex.split(c), stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    stdout, stderr = process.communicate()
    retcode = process.poll()
    return {"retcode": retcode, "stdout": stdout, "stderr": stderr}


def assert_step(r):
    if r is not 0:
        sys.stdout.write('> Something went wrong, aborting...\n')
        sys.exit(1)


def get_agent_filepath(die=False):
    agent_options_filepath = os.path.join(home_dir(), '.watchman-agent.json')
    if not os.path.isfile(agent_options_filepath) and die:
        sys.stdout.write('> Missing watchman-agent.json file; skipping\n')
        sys.exit(1)
    return agent_options_filepath


def home_dir():
    return os.path.expanduser("~")


def get_ip_address_for_interface(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    st = struct.Struct('256s')
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        st.pack(ifname[:15].encode('utf-8'))
    )[20:24])
