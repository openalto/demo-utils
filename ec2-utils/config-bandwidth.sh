#!/bin/bash

IP=$1
PORT=$2
CAPACITY=$3

shift

for port in $@ ; do
    curl -v -X PUT -u admin:admin http://$IP:$PORT/restconf/config/alto-bwmonitor:config-capacity/capacity/$port -H 'Content-type: application/json' -d '{"capacity": {"port-id":"'$port'", "capacity": '$CAPACITY'}}'
done
