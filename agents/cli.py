# -*- coding: utf-8 -*-

import argparse
import sys
import os
import re

try:
    import tasks
    import utils
except ImportError as e:
    from agents import tasks,  utils


parser = argparse.ArgumentParser(description='Agent CLI tool and running instace')
subparsers = parser.add_subparsers(dest='parent')
init_command = subparsers.add_parser(
    'init',
    help='create initial configuration files')
#init_command.add_argument(
#    '--force',
#    action='store_true',
#    default=False,
#    help='forcefully overrides configuration files', dest='argument')
start_command = subparsers.add_parser(
    'start',
    help='start a running process (daemon)')
notify_command = subparsers.add_parser(
    'notify',
    help='notify a master-server (Watcman-Backdoor) about this running agent')


class AgentCLI(object):
    def __init__(self, namespace=None):
        self.namespace = namespace

    def get_module_attribute_safely(self, reference, module):
        namespace = self.namespace
        if hasattr(namespace, reference):
            attr = getattr(namespace, reference)
            attrname = attr.replace('-', '_')
            if hasattr(module, attrname):
                return getattr(module, attrname)
        return None

    def get_task_arguments(self):
        args = vars(self.namespace)
        args.pop('parent')
        return args

    def action(self):
        task_function = self.get_module_attribute_safely('parent', tasks)
        if task_function is None:
            utils.print_error('# Command is not implemented yet')
            return
        args = self.get_task_arguments()
        return task_function(**args)

    @staticmethod
    def apply(argv):
        namespace = parser.parse_args(argv[1:])
        return AgentCLI(namespace).action()
