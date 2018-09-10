#!/bin/sh

IP=${1:-192.168.1.51}
PORT=${2:-8182}

./subscribe-ports.sh 1 $(curl -s -u admin:admin http://$IP:$PORT/restconf/operational/opendaylight-inventory:nodes | jq -r '.nodes.node[]."node-connector"[].id|select(endswith("LOCAL")|not)')
