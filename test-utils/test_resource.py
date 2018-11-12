#!/usr/bin/env python3

import requests
import json
from requests.auth import HTTPBasicAuth

auth = ('admin', 'admin')

def test_bwmonitor_subscribe(hostname, port_ids=["openflow:1:1"]):
    raw_data = {
        "input": {
            "port-id": port_ids
        }
    }
    url = "http://" + hostname + ":8181/restconf/operations/alto-bwmonitor:bwmonitor-subscribe"
    print(url)
    r = requests.post(url, json=raw_data, auth=auth)
    print(r.text)
    return r

def test_bwmonitor_query(hostname, port_ids=["openflow:1:1"]):
    raw_data = {
        "input": {
            "port-id": port_ids
        }
    }
    url = "http://" + hostname + ":8181/restconf/operations/alto-bwmonitor:bwmonitor-query"
    print(url)
    r = requests.post(url, json=raw_data, auth=auth)
    print(r.text)
    return r

def test_resource_query(hostname):
    raw_data = {
    "query-desc": [
        {
        "flow": {
            "flow-id": 1,
            "src-ip": "10.0.1.101",
            "dst-ip": "10.0.2.201",
            "dst-port": 2345
        },
        "ingress-point": ""
        },
        {
        "flow": {
            "flow-id": 2,
            "src-ip": "10.0.1.102",
            "dst-ip": "10.0.3.202",
            "dst-port": 4567
        },
        "ingress-point": ""
        }
    ]
    }
    resp = requests.post("http://" + hostname + ":8080/experimental/v1/unicorn/resource-query", json=raw_data)
    print(resp.text)
    return resp

if __name__ == '__main__':
    #test_bwmonitor_subscribe("unicorn1", ["host:00:00:00:00:00:01/openflow:1:1"])
    #test_bwmonitor_query("unicorn1", port_ids=["host:00:00:00:00:00:01/openflow:1:1"])
    test_resource_query("unicorn1")