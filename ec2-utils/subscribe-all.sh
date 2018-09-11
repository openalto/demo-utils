#!/bin/sh

IP=${1:-localhost}
PORT=${2:-8181}

./subscribe-ports.sh $IP $PORT $(curl -s -u admin:admin http://$IP:$PORT/restconf/operational/opendaylight-inventory:nodes | jq -r '.nodes.node[]."node-connector"[].id|select(endswith("LOCAL")|not)')
