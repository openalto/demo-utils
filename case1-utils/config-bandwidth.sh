#!/bin/bash

CONTROLLER=$1

http_port=$(($1+8181))
capacity=100000

shift

# curl -v -X PUT -u admin:admin http://localhost:8182/restconf/config/alto-bwmonitor:config-capacity/capacity/openflow :1:2 -H 'Content-type: application/json' -d '{"capacity": {"port-id": "openflow:1:2", "capacity": 200000}}' 

for port in $@ ; do
    curl -v -X PUT -u admin:admin http://127.0.0.1:$http_port/restconf/config/alto-bwmonitor:config-capacity/capacity/$port -H 'Content-type: application/json' -d '{"capacity": {"port-id":"'$port'", "capacity": '$capacity'}}'
done
