#!/usr/bin/env python3

from __future__ import print_function
import paramiko
import re
import sys

def execute_remote(command, ip='localhost', port=8101, username='karaf', password='karaf'):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(ip, port=port, username=username, password=password)
    sh = client.invoke_shell()
    sh.settimeout(0.5)

    try:
        buff = ''
        while not buff.endswith('opendaylight-user@root>'):
            resp = sh.recv(9999)
            buff += resp
    except:
        pass
    sh.send(command + "\n")
    buff = ''
    while True:
        try:
            buff = ''
            while not buff.endswith('opendaylight-user@root>'):
                resp = sh.recv(9999)
                buff += resp
        except:
            new_buff = re.compile(r'(\x9B|\x1B\[)[0-?]*[ -/]*[@-~].*\n$').sub('', buff).replace('\b', '').replace('\r', '')
            newnewbuff = re.compile(r'.*>$').sub('', new_buff)
            newnewnewbuff = re.compile(r'.*{}.*'.format(command)).sub('', newnewbuff)
            print(newnewnewbuff.strip('\n'))
            break

def parse_argument():
    import argparse
    parser = argparse.ArgumentParser(description='Execute remote command via ssh.')
    parser.add_argument('-c', '--controller', dest='controller',
                        type=str, default='localhost',
                        help='IP address of SDN controller.')
    parser.add_argument('-p', '--port', dest='port',
                        type=int, default=8101,
                        help='SSH port of the SDN controller.')
    parser.add_argument('-l', '--login', dest='login',
                        type=str, default='karaf',
                        help='SSH login name of the SDN controller.')
    parser.add_argument('-P', '--password', dest='password',
                        type=str, default='karaf',
                        help='SSH password of the SDN controller.')
    parser.add_argument('command', nargs='?')
    return parser.parse_args(sys.argv[1:])

if '__main__' == __name__:
    args = parse_argument()
    if args.command:
        command = args.command
    else:
        command = sys.stdin.readline().strip("\n")
    execute_remote(command)
