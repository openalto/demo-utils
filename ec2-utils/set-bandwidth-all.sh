!/bin/bash

IP=${1:-localhost}
PORT=${2:-8181}
CAPACITY=${3-100000}

./config-bandwidth.sh $IP $PORT $CAPACITY $(curl -s -u admin:admin http://$IP:$PORT/restconf/operational/opendaylight-inventory:nodes | jq -r '.nodes.node[]."node-connector"[].id|select(endswith("LOCAL")|not)')
