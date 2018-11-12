#!/usr/bin/env python3

import requests
import json

def test_query(hostname, port):
    data = {
        "input":
            # {
            #     "src-ip": "10.0.1.101",
            #     "dst-ip": "10.0.2.201",
            #     "protocol": "TCP"
            # }
            {
                "src-ip": "10.0.1.102",
                "dst-ip": "10.0.3.202",
                "protocol": "TCP"
            }
    }
    r = requests.post("http://" + hostname + ":" + str(port) + "/query", json=data)
    print(r.text)

def test_path_query(hostname, port):
    data = {
      "flows": [
        {
          "src": "10.0.1.101",
          "dst": "10.0.2.201",
          "ingress": "openflow:4:1"
        },
        {
          "src": "10.0.1.102",
          "dst": "10.0.3.202",
          "ingress": "openflow:4:2"
        }
      ]
    }
    r = requests.post("http://" + hostname + ":" + str(port) + "/path-query", json=data)
    print(r.text)

if __name__ == '__main__':
    test_path_query("unicorn1", 8399)