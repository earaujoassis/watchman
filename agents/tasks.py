
# -*- coding: utf-8 -*-

import sys
import os
import requests
import json
import base64
import socket

from mako.template import Template
from agents.utils import run, get_agent_filepath
from agents.utils import get_ip_address_for_interface
from agents import version


def init():
    watchman_backdoor = ""
    client_key = ""
    client_secret = ""

    print("> All right, let's initiate an agent instance")
    while len(watchman_backdoor) == 0:
        watchman_backdoor = input("What is the base URL for the Watchman-Backdoor server: ").strip().rstrip("/")
    while len(client_key) == 0:
        client_key = input("What is the client key for that backdoor server: ").strip()
    while len(client_secret) == 0:
        client_secret = input("And what is the client secret for that backdoor server: ").strip()

    agent_filepath = get_agent_filepath(die=False)
    with open(agent_filepath, 'w') as agent_file:
        current_project_path = os.path.dirname(__file__)
        template_filepath = os.path.join(current_project_path, 'templates', 'watchman-agent.json')
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
        authorization_clear = '{0}:{1}'.format(agent_data['client_key'], agent_data['client_secret']).encode('utf-8')
        authorization = base64.b64encode(bytearray(authorization_clear))
        response = requests.put('{0}/api/servers/notify'.format(
            agent_data['watchman_backdoor']),
            headers={
                'Authorization': 'Bearer {0}'.format(authorization.decode('utf-8'))
            },
            json={
                'server': {
                    'hostname': socket.gethostname(),
                    'ip': get_ip_address_for_interface('eth0'),
                },
            })
        if response.status_code >= 200 and response.status_code < 300:
            response_data = response.json()
            if response_data['version'] > version:
                sys.stdout.write('> Version mismatch; updating agent\n')
                run('pip3 install --user https://github.com/earaujoassis/wathcman/archive/{0}.zip'.format(response_data['version']))
                sys.stdout.write('> Agent updated\n')
            sys.stdout.write('> Successfully notified\n')
            sys.exit(0)
        else:
            sys.stdout.write('> Oops! Notification failed\n')
            sys.stdout.write('> Error: {0}\n'.format(response.content))
            sys.exit(1)
