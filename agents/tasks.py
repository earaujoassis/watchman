
# -*- coding: utf-8 -*-

import sys
import os
import tempfile
import subprocess
import requests
import json
import base64
import socket

from mako.template import Template
from agents.utils import run, get_agent_filepath
from agents.utils import get_ip_address_for_interface
from agents.utils import authorization_bearer
from agents.metadata import version


GITHUB_STRING = 'https://github.com/earaujoassis/watchman/archive/v{0}.zip'


def init():
    watchman_backdoor = ""
    client_key = ""
    client_secret = ""

    print("> All right, let's initiate an agent instance")
    while len(watchman_backdoor) == 0:
        watchman_backdoor = input(
                "What is the base URL for the Watchman-Backdoor server: ") \
            .strip() \
            .rstrip("/")
    while len(client_key) == 0:
        client_key = input(
                "What is the client key for that backdoor server: ") \
            .strip()
    while len(client_secret) == 0:
        client_secret = input(
                "And what is the client secret for that backdoor server: ") \
            .strip()

    agent_filepath = get_agent_filepath(die=False)
    with open(agent_filepath, 'w') as agent_file:
        current_project_path = os.path.dirname(__file__)
        template_filepath = os.path.join(
            current_project_path,
            'templates',
            'watchman-agent.json')
        template = Template(filename=template_filepath)
        template_render = template.render(**{
            'watchman_backdoor': watchman_backdoor,
            'client_key': client_key,
            'client_secret': client_secret,
        })
        agent_file.write(template_render)


def notify():
    agent_filepath = get_agent_filepath(die=True)
    with open(agent_filepath, 'r') as agent_file:
        agent_data = json.load(agent_file)
        authorization = authorization_bearer(
            agent_data['client_key'],
            agent_data['client_secret']
        )
        response = requests.put('{0}/api/servers/notify'.format(
            agent_data['watchman_backdoor']),
            headers={
                'Authorization': 'Bearer {0}'.format(
                    authorization),
            },
            json={
                'server': {
                    'hostname': socket.gethostname(),
                    'ip': get_ip_address_for_interface('eth0'),
                    'latest_version': version,
                },
            })
        if response.status_code >= 200 and response.status_code < 300:
            response_data = response.json()
            if response_data['version'] > version:
                sys.stdout.write('> Version mismatch; updating agent\n')
                install_str = GITHUB_STRING.format(response_data['version'])
                run('pip3 install --user {0}'.format(install_str))
                sys.stdout.write('> Agent updated\n')
            else:
                sys.stdout.write('> No update available\n')
            sys.stdout.write('> Successfully notified\n')
            sys.exit(0)
        else:
            sys.stdout.write('> Oops! Notification failed\n')
            sys.stdout.write('> Error: {0}\n'.format(response.content))
            sys.exit(1)


def report(subject, command):
    agent_filepath = get_agent_filepath(die=True)
    with open(agent_filepath, 'r') as agent_file:
        agent_data = json.load(agent_file)
        authorization = authorization_bearer(
            agent_data['client_key'],
            agent_data['client_secret']
        )

        response = requests.post('{0}/api/servers/report'.format(
            agent_data['watchman_backdoor']),
            headers={
                'Authorization': 'Bearer {0}'.format(authorization),
            },
            json={
                'server': {
                    'hostname': socket.gethostname(),
                    'ip': get_ip_address_for_interface('eth0'),
                    'latest_version': version,
                },
                'report': {
                    'subject': subject,
                },
            })

        if response.status_code >= 200 and response.status_code < 300:
            response_data = response.json()
        else:
            sys.stdout.write('> Oops! Report failed\n')
            sys.stdout.write('> Error: {0}\n'.format(response.content))
            sys.exit(1)

        report_id = response_data['report']['id']
        message_body = subprocess.Popen(
            command, stdout=subprocess.PIPE).stdout.read().decode('utf-8')
        tmpfile = tempfile.NamedTemporaryFile("w")
        tmpfile.write(message_body)
        tmpfile.flush()
        tmpfile.seek(0)

        response = requests.put('{0}/api/servers/report/{1}'.format(
            agent_data['watchman_backdoor'],
            report_id),
            headers={
                'Authorization': 'Bearer {0}'.format(authorization),
            },
            files={
                'report[body]': open(tmpfile.name),
            })

        if response.status_code >= 200 and response.status_code < 300:
            sys.stdout.write('> Successfully reported\n')
            sys.exit(0)
        else:
            sys.stdout.write('> Oops! Report failed\n')
            sys.stdout.write('> Error: {0}\n'.format(response.content))
            sys.exit(1)
