#!/usr/bin/env python

import sys
import json

def filtered_flow(nodes, head='#UF'):
    for n in nodes:
        node_id = n['id']
        for t in n.get('flow-node-inventory:table', []):
            table_id = t['id']
            cookies = []
            for f in t.get('flow', []):
                if f['id'].startswith(head) and f.get('cookie', 'unknown') not in cookies:
                    cookies.append(f.get('cookie', 'unknown'))
            for cookie in cookies:
                sys.stdout.write("%s %d %s\n" % (node_id, table_id, cookie))

def parse_argument():
    import argparse
    parser = argparse.ArgumentParser(description='ODL Flow Filter.')
    parser.add_argument('-H', '--head', dest='head',
                        type=str, default='',
                        help='Filter the flow whose name starts with <head>.')
    parser.add_argument('data', nargs='?')
    return parser.parse_args(sys.argv[1:])

if '__main__' == __name__:
    args = parse_argument()
    if args.data:
        raw_data = json.load(open(args.data))
    else:
        raw_data = json.load(sys.stdin)

    filtered_flow(raw_data['nodes']['node'], head=args.head)
